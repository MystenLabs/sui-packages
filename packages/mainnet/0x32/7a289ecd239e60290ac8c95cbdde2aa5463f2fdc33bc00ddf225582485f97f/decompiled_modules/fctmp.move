module 0x327a289ecd239e60290ac8c95cbdde2aa5463f2fdc33bc00ddf225582485f97f::fctmp {
    struct FCTMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCTMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCTMP>(arg0, 9, b"FCTMP", b"FckTrump", b"We want Gojo as president not Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2992e8e4-723a-4049-ab6d-a06b62e6de79.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCTMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCTMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

