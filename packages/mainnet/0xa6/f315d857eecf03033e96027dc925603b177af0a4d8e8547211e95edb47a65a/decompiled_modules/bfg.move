module 0xa6f315d857eecf03033e96027dc925603b177af0a4d8e8547211e95edb47a65a::bfg {
    struct BFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFG>(arg0, 6, b"BFG", b"Baby Fart Gas", b"There is nothing funnier than hearing a Baby Fart Gas, the meme coin will put a smile on your face, because that is the true meaning of a meme coin, it supposed to be funny, let take this coin to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739801173504.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BFG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

