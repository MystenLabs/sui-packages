module 0xe95a86ef1f48d68b4e5784fc1df5f27eb578920d2d7765443f4c6f472b82a973::bullseye {
    struct BULLSEYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLSEYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLSEYE>(arg0, 6, b"Bullseye", x"f09f8eaf", x"f09f8eaff09f8eaff09f8eaff09f8eaf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731710728093.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLSEYE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLSEYE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

