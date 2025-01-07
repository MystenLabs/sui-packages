module 0xb1ba2ff2c84bbc3257cef221e5f7ed4742d3f43168d15795d1357e84c491049b::commie {
    struct COMMIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMMIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMMIE>(arg0, 6, b"Commie", b"Commie Harris", b"The dictator who's dragging us towards communism.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/commiegif_3fe2676011.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMMIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COMMIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

