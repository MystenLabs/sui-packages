module 0xcc10e3edf2ddb41e6c18c0422f614ec1c1ecfb56c9e024b04aa59f03c107c9a::dcky {
    struct DCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCKY>(arg0, 9, b"DCKY", b"DuckyDuck", b"Token for someone have a duck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e68ecae3-1f71-4375-9902-eb20fbd1a75c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

