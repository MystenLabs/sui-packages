module 0x96f419b12c72da712e754993865bd491be1f99298c1ed963db5ea807f2089f47::ploo {
    struct PLOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOO>(arg0, 6, b"PLOO", b"PLOOPCAT", b"Hi I'm Ploopcat, a crazy cat that will make all the animals will send down soldiers to attack me alone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054290_4b009c109c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

