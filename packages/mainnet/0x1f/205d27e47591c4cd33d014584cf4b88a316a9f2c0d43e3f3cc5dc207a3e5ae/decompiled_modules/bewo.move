module 0x1f205d27e47591c4cd33d014584cf4b88a316a9f2c0d43e3f3cc5dc207a3e5ae::bewo {
    struct BEWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEWO>(arg0, 6, b"BEWO", b"Blue Eyes White Omnicat", b"Bewo was used for experiments by SUI scientists, now he roams free.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049769_80cff9f01c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

