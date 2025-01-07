module 0x3be824818c061024c09caa6157c3ae3d6863d4cf88860bb12dbbba623e2c1399::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAM>(arg0, 9, b"SAM", b"SAMDWICH", b"The first ever Sui RWA-Memecoin in history! Join $SAM revolution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1798782214668423168/6bJS-wEd_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

