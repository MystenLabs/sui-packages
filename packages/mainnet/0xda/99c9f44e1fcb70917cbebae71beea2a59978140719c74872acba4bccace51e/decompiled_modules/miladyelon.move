module 0xda99c9f44e1fcb70917cbebae71beea2a59978140719c74872acba4bccace51e::miladyelon {
    struct MILADYELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILADYELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILADYELON>(arg0, 6, b"MILADYELON", b"MilladyElon", x"4d696c616479456c6f6e206973206d656d65636f696e20696e20612020696e737069726564206279207374726565740a7374796c6520747269626573204d696c616479204d616b657220616e6420456c6f6e204d75736b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GP_Sr_A_H_Xc_AA_9_Gx_Z_e549837d05.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILADYELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILADYELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

