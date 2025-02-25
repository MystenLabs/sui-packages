module 0xc60a02868034baa85fff559110d685385ebae33cb6dfa7bb42ca2183f638f61e::stan {
    struct STAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAN>(arg0, 9, b"STAN", b"Stan Lee", b"Stan Lee was a comic book writer, editor, publisher, and producer who was the driving force behind the popular Marvel franchise.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/7/7b/Stan_Lee_by_Gage_Skidmore_3.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STAN>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAN>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

