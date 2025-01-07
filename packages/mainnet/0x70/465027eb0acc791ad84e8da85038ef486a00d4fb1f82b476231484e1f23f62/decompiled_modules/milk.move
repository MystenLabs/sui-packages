module 0x70465027eb0acc791ad84e8da85038ef486a00d4fb1f82b476231484e1f23f62::milk {
    struct MILK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MILK>(arg0, 6, b"MILK", b"BOOBIES", b"MILK THE SUI ECOSYSTEM FOR PROSPERITY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/boobies_a9e69aecde.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MILK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

