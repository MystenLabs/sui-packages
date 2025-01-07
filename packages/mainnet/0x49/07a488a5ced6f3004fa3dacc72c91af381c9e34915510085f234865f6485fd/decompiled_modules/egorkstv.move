module 0x4907a488a5ced6f3004fa3dacc72c91af381c9e34915510085f234865f6485fd::egorkstv {
    struct EGORKSTV has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGORKSTV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGORKSTV>(arg0, 9, b"EGORKSTV", b"egorkstv", b"The best token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0c089a87-9d04-485a-85d7-754dfc1af1e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGORKSTV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGORKSTV>>(v1);
    }

    // decompiled from Move bytecode v6
}

