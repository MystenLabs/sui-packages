module 0x9d9923b04e4aa8fdd7249fe17507f0cab862b036acef9c329ea8ff8edc2b7b80::magahat {
    struct MAGAHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGAHAT>(arg0, 6, b"Magahat", b"Dark Maga", b"Dark maga hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029710_605e523d40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGAHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGAHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

