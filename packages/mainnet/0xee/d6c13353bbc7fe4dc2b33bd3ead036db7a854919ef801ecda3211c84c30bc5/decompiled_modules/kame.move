module 0xeed6c13353bbc7fe4dc2b33bd3ead036db7a854919ef801ecda3211c84c30bc5::kame {
    struct KAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAME>(arg0, 6, b"KAME", b"KAME THE MARTER", x"4b414d45200a0a4d7220526f7368692077616e747320746f206275696c642061206e657720686f75736520746f2066697420696e206d6f72652070656f706c65200a0a57616e6e61206a6f696e3f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifzxevmnt7mertvwq3sfxz7nqrtoni4usve4453bevwshan4ywzj4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KAME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

