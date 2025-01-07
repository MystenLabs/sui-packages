module 0x5d2be9d4b1519234d78006e4e4ef87bc56eb00d0a8f3fb72d76b5dc4d1978c39::minic {
    struct MINIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINIC>(arg0, 6, b"MINIC", b"Minion cat", b"minions always together! Memcoin from community for community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2046_5969a36712.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

