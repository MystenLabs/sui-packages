module 0xeae40459657834623ec43f13e43bba2dc72e23455bbe22806e124fbffd31343b::pfrog {
    struct PFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PFROG>(arg0, 6, b"PFROG", b"PinkFrog", b"swiming for the dollar in the sui pond", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/828e04e086b186f5db218be438c25993_1964750f7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

