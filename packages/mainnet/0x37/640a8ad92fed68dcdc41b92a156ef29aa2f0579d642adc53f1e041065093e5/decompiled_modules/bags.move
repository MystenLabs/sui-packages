module 0x37640a8ad92fed68dcdc41b92a156ef29aa2f0579d642adc53f1e041065093e5::bags {
    struct BAGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAGS>(arg0, 6, b"BAGS", b"BAGS on Sui", b"This is real Bags!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951113286.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

