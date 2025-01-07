module 0xa3f2d3e9c5d3d61ca95eaf6f1ce5b75c8208ffc407b92c47cbf29731cccf9c78::mmk {
    struct MMK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMK>(arg0, 9, b"MMK", b"Memek", b"This memek token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/65ed22e5-320f-49c6-bc9a-615cb3c00638.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMK>>(v1);
    }

    // decompiled from Move bytecode v6
}

