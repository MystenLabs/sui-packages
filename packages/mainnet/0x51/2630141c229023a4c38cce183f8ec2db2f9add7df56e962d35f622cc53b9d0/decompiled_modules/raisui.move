module 0x512630141c229023a4c38cce183f8ec2db2f9add7df56e962d35f622cc53b9d0::raisui {
    struct RAISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAISUI>(arg0, 9, b"RAISUI", b"Raisui", b"The Sparkling Flame", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images2.alphacoders.com/130/thumb-1920-1309344.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RAISUI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAISUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

