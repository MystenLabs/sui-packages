module 0xa2f9d7d1221b3a49565636b64a13da61d0dafaebd878ad0f2600509f17f2ace2::ama {
    struct AMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMA>(arg0, 9, b"AMA", b"Amanda", b"My Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e013502c9d006fe0c343f1db7478b95cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

