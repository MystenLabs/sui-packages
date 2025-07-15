module 0xef65d73f10fd656d78a50f93189963c5bd4fd2d20f922d96df03dbdfed59fa4e::hippsy {
    struct HIPPSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPSY>(arg0, 6, b"HIPPSY", b"Hiphop On Sui", b"Meme born the Well", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibnyzzgsz44b42cd755jwrashvovpe2zvqigw6kv7qjhipu2tozie")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HIPPSY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

