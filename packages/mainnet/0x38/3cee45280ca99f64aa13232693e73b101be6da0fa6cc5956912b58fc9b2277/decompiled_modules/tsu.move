module 0x383cee45280ca99f64aa13232693e73b101be6da0fa6cc5956912b58fc9b2277::tsu {
    struct TSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSU>(arg0, 9, b"TSU", b"TERSUI", b"sui de trump elon musk meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ce176f494de604f3e4e80f4fa1bb7b5fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

