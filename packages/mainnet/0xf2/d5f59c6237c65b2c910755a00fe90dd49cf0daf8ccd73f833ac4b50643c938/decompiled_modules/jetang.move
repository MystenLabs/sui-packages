module 0xf2d5f59c6237c65b2c910755a00fe90dd49cf0daf8ccd73f833ac4b50643c938::jetang {
    struct JETANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JETANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JETANG>(arg0, 9, b"JETANG", b"Jelly Tang", b"Get some money make some money. Scared money don't make no money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/699/582/large/jelly-tang-03.jpg?1728300271")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JETANG>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JETANG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JETANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

