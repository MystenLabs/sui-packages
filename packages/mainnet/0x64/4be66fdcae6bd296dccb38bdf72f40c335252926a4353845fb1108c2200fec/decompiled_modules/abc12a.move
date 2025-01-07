module 0x644be66fdcae6bd296dccb38bdf72f40c335252926a4353845fb1108c2200fec::abc12a {
    struct ABC12A has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABC12A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABC12A>(arg0, 6, b"ABC12a", b"ABC1", b"12312", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bridge_comfirm_9a395f6db7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABC12A>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABC12A>>(v1);
    }

    // decompiled from Move bytecode v6
}

