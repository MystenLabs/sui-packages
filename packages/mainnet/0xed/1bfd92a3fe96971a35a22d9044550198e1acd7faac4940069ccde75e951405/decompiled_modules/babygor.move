module 0xed1bfd92a3fe96971a35a22d9044550198e1acd7faac4940069ccde75e951405::babygor {
    struct BABYGOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYGOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYGOR>(arg0, 6, b"BABYGOR", b"Baby Gorbagana Sui", b"Most adorable little sibling of the legendary Gorbagana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihu637xkxiy5ba2c3di5lv5r3ahjr47yn6r2rjxzx3dy7qymbejku")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYGOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BABYGOR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

