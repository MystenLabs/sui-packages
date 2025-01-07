module 0x6b33c6ea7b8a47aac9df545df47a4afc3f853783d2c7de8e91560deb4b557cd6::wawes {
    struct WAWES has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWES>(arg0, 9, b"WAWES", b"wawes", b"token 2049", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ad0778cc-23ae-438d-a358-7dc78f8555f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAWES>>(v1);
    }

    // decompiled from Move bytecode v6
}

