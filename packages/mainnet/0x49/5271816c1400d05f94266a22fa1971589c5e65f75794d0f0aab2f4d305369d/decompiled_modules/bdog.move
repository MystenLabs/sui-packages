module 0x495271816c1400d05f94266a22fa1971589c5e65f75794d0f0aab2f4d305369d::bdog {
    struct BDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDOG>(arg0, 6, b"BDOG", b"BunnyDog", b"BunnyDog on Turbo's eating Hotdogs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731013068892.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

