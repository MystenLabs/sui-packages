module 0x6d820edbffcb279dcae979fa0c117722485fd258bc0aa0bc745137a45a3561d1::world {
    struct WORLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORLD>(arg0, 6, b"World", b"Hello World 4", x"6869686920686168c3a2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaaanx6zk2ms53kiwrrwyy2re53zjz46rwlwuv2pyc5bmewx4p5fq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WORLD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

