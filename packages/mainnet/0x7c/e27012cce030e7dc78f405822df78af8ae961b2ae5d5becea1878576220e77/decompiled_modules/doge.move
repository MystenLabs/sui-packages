module 0x7ce27012cce030e7dc78f405822df78af8ae961b2ae5d5becea1878576220e77::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 9, b"DOGE", b"The Dep Of Government Efficiency", b"The Department Of Government Efficiency (D.O.G.E) is the brainchild of Elon Musk and Donald Trump. Trump has appointed Musk to head the Department and reign in US Government spending and waste. We support this initiative and plan to bring awareness to the movement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreiamvhuvvx3rffzni5h6ehcn7t6x6u5r5oymwhnloopqovkm2bchpa.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

