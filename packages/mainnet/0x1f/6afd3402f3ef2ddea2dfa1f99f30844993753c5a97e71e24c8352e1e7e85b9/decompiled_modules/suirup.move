module 0x1f6afd3402f3ef2ddea2dfa1f99f30844993753c5a97e71e24c8352e1e7e85b9::suirup {
    struct SUIRUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRUP>(arg0, 6, b"Suirup", b"Lean Codeine Sui", b"Lean is known for its relaxing and euphoric effects, combining cough syrup with soda for a unique experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asdmnhjkhjk_c9a83ae3d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

