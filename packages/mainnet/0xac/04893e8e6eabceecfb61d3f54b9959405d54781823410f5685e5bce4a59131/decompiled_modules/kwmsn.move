module 0xac04893e8e6eabceecfb61d3f54b9959405d54781823410f5685e5bce4a59131::kwmsn {
    struct KWMSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KWMSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KWMSN>(arg0, 9, b"KWMSN", b"hsien", b"dhjsn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a4ae57d1-7d77-455e-81bc-599bf4e67c54.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KWMSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KWMSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

