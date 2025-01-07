module 0xc7513b169b34a140113963c059eb413c16cb35008f38d1c1be9f9d4104a9b282::bopcat {
    struct BOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOPCAT>(arg0, 6, b"Bopcat", b"Bopcat Sui", b"The Memecoin you didn't Know You Needed On Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9242_3895ec7d7f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

