module 0xb6970c52abc4e0d73ce287de6282bc8ca2d116389e372336ad713a3ed25361f0::flowy {
    struct FLOWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOWY>(arg0, 9, b"FLOWY", b"FlowyFinanceDog", b"Hello, I'm Flowy the flow finance dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.etsystatic.com/13348558/r/il/a29ab1/2918306283/il_fullxfull.2918306283_ojql.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLOWY>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOWY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOWY>>(v1);
    }

    // decompiled from Move bytecode v6
}

