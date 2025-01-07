module 0x9840656b81d304e84af6b833bf3b7b6b1399596c2793f741b4613957e2a8c25e::bdc {
    struct BDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDC>(arg0, 6, b"BDC", b"BILLIONDOLLARCAT", b"billy to a billy  $BDC on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wv_A945q_L_400x400_32c6dde18a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

