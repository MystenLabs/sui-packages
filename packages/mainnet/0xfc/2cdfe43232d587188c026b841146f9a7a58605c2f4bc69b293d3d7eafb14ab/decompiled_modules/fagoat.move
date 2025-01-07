module 0xfc2cdfe43232d587188c026b841146f9a7a58605c2f4bc69b293d3d7eafb14ab::fagoat {
    struct FAGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAGOAT>(arg0, 9, b"FAGOAT", b"FAGGOAT", x"4a6f696e20746865204669617420416e6e7573204772616e646973204775696c6420206f662074686520474f415421204a6f696e2074686520646565702c2064656570206d697374657279206f66205572416e75732e200a596f752062757920616e642074726164652074686520696465612e2045766572797468696e6720656c7365206c696b6520582c2054472c2077696c6c20636f6d65206172726f756e64206166746572206c697374696e672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6d1b8a21447949dfce6af4ed906406ecblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAGOAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAGOAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

