module 0xe8a173152d6e8a976e2902d142abf85485f2efbf8d6b3d050141468e3627ac97::xbh {
    struct XBH has drop {
        dummy_field: bool,
    }

    fun init(arg0: XBH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XBH>(arg0, 9, b"XBH", b"Xen bo hun", x"58c3aa6e2042e1bb8d2048756e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d9060d64-7b14-4a2b-a08f-3b419cc35ba0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XBH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XBH>>(v1);
    }

    // decompiled from Move bytecode v6
}

