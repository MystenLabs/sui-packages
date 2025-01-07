module 0xa975070d4bead8579572d35ae02e110ca2f05e981b3d36043157b87a390b67e8::sims {
    struct SIMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMS>(arg0, 8, b"SIMS", b"Simoleon", b"Klapaucius!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZtoGw5AY48lN28RDXutKdsysu0NKFsVhlHw&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIMS>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

