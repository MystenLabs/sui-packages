module 0xd43b327543e1eb19805e33c3388d98aecc1eff9630af2b132a768ba87e318358::wct {
    struct WCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCT>(arg0, 9, b"WCT", b"WeCat", b"Cat who beg wewe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e155e7f7-b6d4-4225-abb0-d69c7bd6cb39.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

