module 0x88b79812b1a5adf88b7ccf847f90c6ca068f630f9fb8a0f4b7efe990fcdc64e::xai {
    struct XAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XAI>(arg0, 9, b"XAI", b"Xai Memes", x"f09fa496205841492d4d656d65206973207468652066697273742041492d4d656d652070726f6a65637420617420535549206e6574776f726b2e20204974e28099732074686520736d617274657374206d656d6520696e207468652063727970746f20776f726c642e20205765e280996c6c20616c6c207769746e657373206974732073746f727920736f6f6e2e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1853486239007092737/TP4xZ89Y_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

