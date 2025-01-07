module 0x65bb642d099dcd3a9b5a5fc006c4f3cb327a6289ec316c346e703bdb0d6fba62::off {
    struct OFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: OFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OFF>(arg0, 6, b"OFF", b"OfficinaDefi", b"we are workers with a single purpose, to change the crypto world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/officina_4b58ed0a22.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

