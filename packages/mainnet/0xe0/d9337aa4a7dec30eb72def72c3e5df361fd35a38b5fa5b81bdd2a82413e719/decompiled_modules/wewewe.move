module 0xe0d9337aa4a7dec30eb72def72c3e5df361fd35a38b5fa5b81bdd2a82413e719::wewewe {
    struct WEWEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWEWE>(arg0, 9, b"WEWEWE", b"WEWE", b"WEWEWEWE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/562b5449-1841-434a-8cd6-579c3825526f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

