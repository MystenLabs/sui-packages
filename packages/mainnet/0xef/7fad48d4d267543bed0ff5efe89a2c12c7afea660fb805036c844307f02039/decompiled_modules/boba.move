module 0xef7fad48d4d267543bed0ff5efe89a2c12c7afea660fb805036c844307f02039::boba {
    struct BOBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBA>(arg0, 6, b"Boba", b"Bobasui", b"The Dogecoin founder's Cat---Boba. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/K8rd6tl9_400x400_044be28df8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

