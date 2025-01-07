module 0xd08578cae54d440111728d4c557b6aaf62470ce9b34c1518487ce7dc64d5af06::suitism {
    struct SUITISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITISM>(arg0, 6, b"SUITISM", b"SUITIMS", b"Experiment test engange on Sui. Turbos user can you do something?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730968999062.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITISM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITISM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

