module 0xcf1a09c35911d23d257863fb2fbcf2504aab5017fb894c423990864dbe2ce4ce::snkr {
    struct SNKR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNKR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNKR>(arg0, 9, b"SNKR", b"Snake ", b"Its been a hot cake", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e928ee4c-c954-4f82-a3fe-24325be766df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNKR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNKR>>(v1);
    }

    // decompiled from Move bytecode v6
}

