module 0xc39b0f7db0230cbe49c9f08d7ea5110aaf5f112b1c7af65e6571ea84b732bd2b::wtp {
    struct WTP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTP>(arg0, 9, b"WTP", b"walrus LOVER", b"walrus TGE pass", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0ae43b39b40cb090ebd72e05371e6e4bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

