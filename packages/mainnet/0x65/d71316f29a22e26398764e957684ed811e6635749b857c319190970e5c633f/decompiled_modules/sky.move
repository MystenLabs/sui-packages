module 0x65d71316f29a22e26398764e957684ed811e6635749b857c319190970e5c633f::sky {
    struct SKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKY>(arg0, 9, b"SKY", b"SevenKey", b"Just a Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/2cd230889b5041170e6cf65e283095d0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

