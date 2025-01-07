module 0x3c5a5eb32422e4b478db73b4157406259201ad82b21c27344329e6c073bff2b9::xrp {
    struct XRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: XRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XRP>(arg0, 9, b"XRP", b"XRP on Solana", x"45766572796f6e65206f6e2054696b546f6b2069732068797065642061626f7574205852502c20627574206e6f206f6e65206b6e6f777320776861742069742061637475616c6c792069732e2054696d6520666f7220746865207265616c2024585250206f6e20536f6c616e6120746f2074616b65206f766572e280946e6f772074686520776f726c642077696c6c206b6e6f77207768617420585250207472756c79206d65616e7321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreicxp7ojmkwzzl23s7a2rhufj2z4z2l6jybpsadlkrjzx5lwbnnzaq.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XRP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XRP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

