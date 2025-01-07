module 0x59bc63fca003a5cb266e47b183e7efba155892893c2108cc291a2f4a96a941e6::kimchi {
    struct KIMCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIMCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIMCHI>(arg0, 6, b"KIMCHI", b"KIMCHI TOKEN", b"Get Spicy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kimchifinance_177b4c383f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIMCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIMCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

