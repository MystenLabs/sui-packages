module 0x2b6817783952e8567be8ab575794cb5fc1e1ad75cb9b31f9bc629e2f2f659f0d::spacex {
    struct SPACEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPACEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPACEX>(arg0, 6, b"SpaceX", b"Space X", x"5370616365582064657369676e732c206d616e75666163747572657320616e64206c61756e636865732074686520776f726c6473206d6f737420616476616e63656420726f636b65747320616e6420737061636563726166740a5370616365582069732074686520666972737420736d61727420636f696e206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hbr_I04t_M_400x400_b2723e5c55.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPACEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

