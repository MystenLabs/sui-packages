module 0x328c9234a21373f831dd5dd07dc4baa7630341e36c48522c9fabeb9686ee67da::mugi {
    struct MUGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUGI>(arg0, 6, b"MUGI", b"Mugi on Sui", b"The little brother of Doge and Neiro! Cutest member of the Kabosumama family! OG Mugi on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000468010_c320a46774.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

