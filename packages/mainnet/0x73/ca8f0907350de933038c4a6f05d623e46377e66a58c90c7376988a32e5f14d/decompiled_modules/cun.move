module 0x73ca8f0907350de933038c4a6f05d623e46377e66a58c90c7376988a32e5f14d::cun {
    struct CUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUN>(arg0, 9, b"CUN", b"UNICORN", b"IF YOU DON,T BUY IT . IT WILL KILL YOU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/70163d76-b23e-4ddc-b469-3e9d7188b1ed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

