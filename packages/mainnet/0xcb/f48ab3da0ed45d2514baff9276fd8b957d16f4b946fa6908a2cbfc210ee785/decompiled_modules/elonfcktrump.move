module 0xcbf48ab3da0ed45d2514baff9276fd8b957d16f4b946fa6908a2cbfc210ee785::elonfcktrump {
    struct ELONFCKTRUMP has drop {
        dummy_field: bool,
    }

    public entry fun burn_treasury_cap(arg0: 0x2::coin::TreasuryCap<ELONFCKTRUMP>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ELONFCKTRUMP>>(arg0);
    }

    fun init(arg0: ELONFCKTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONFCKTRUMP>(arg0, 6, b"$EFT", b"elonfcktrump", b"elon n' trump war on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/mahmhub/elonfcktrump/main/image.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELONFCKTRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ELONFCKTRUMP>>(0x2::coin::mint<ELONFCKTRUMP>(&mut v2, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONFCKTRUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

