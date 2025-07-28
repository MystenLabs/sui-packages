module 0x51741d66b7abf6ef2376aaea1ef5252c67ef5d69fbfb9bbe7dfd6b1f59e14ace::neko {
    struct NEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEKO>(arg0, 6, b"Neko", b"Neko The Cat", b"In a sleepy corner of the world, where gardens whispered and rooftops glowed in the amber light of dusk, lived a small but confident cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidvn37pljmhslsowjtak6cnqifyqi2cfjb4xcg5qabrf6zta2cs4i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEKO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

