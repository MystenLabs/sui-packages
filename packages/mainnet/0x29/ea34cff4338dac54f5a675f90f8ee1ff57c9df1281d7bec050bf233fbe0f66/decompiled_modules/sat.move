module 0x29ea34cff4338dac54f5a675f90f8ee1ff57c9df1281d7bec050bf233fbe0f66::sat {
    struct SAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAT>(arg0, 9, b"SAT", b"Sat Suimen", b"Sat Suimen is the experiment token for greater project.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lansusamen.fun/assets/images/lan-face.PNG")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAT>>(v1);
        0x2::coin::mint_and_transfer<SAT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

