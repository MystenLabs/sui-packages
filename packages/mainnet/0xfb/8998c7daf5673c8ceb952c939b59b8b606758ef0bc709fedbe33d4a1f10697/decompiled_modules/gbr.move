module 0xfb8998c7daf5673c8ceb952c939b59b8b606758ef0bc709fedbe33d4a1f10697::gbr {
    struct GBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBR>(arg0, 9, b"GBR", b"KHP", b"Going out to eat with ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/897f4256-5480-4145-8ab8-1f51705cd0ff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

