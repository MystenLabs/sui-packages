module 0x445bf8e95bdf6fd3a4d365fa0d880d0d73fe88d96277054a3070caf6647832b4::berry {
    struct BERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERRY>(arg0, 9, b"BERRY", b"Bluberry", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnSeoRp98bDM789VhqjdoayQp_yr0yOc9Uww&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BERRY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERRY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

