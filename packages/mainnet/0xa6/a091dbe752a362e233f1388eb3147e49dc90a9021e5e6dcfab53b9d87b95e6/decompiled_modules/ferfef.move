module 0xa6a091dbe752a362e233f1388eb3147e49dc90a9021e5e6dcfab53b9d87b95e6::ferfef {
    struct FERFEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FERFEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FERFEF>(arg0, 6, b"FERFEF", b"ferfe", b"ferfer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FERFEF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FERFEF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

