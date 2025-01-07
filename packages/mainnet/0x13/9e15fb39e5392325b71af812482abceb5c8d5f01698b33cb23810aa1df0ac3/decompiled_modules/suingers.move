module 0x139e15fb39e5392325b71af812482abceb5c8d5f01698b33cb23810aa1df0ac3::suingers {
    struct SUINGERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINGERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINGERS>(arg0, 6, b"SUINGERS", b"SUIngers of Sui", b"The Suingers of SUI have arrived! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/1b7c015c_eea5_44cc_aa8e_e7c0370c3ccc_bb0e25faef.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINGERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINGERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

