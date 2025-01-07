module 0x1cd6de4ec0bca472df5f1388816eb0ab30738c25a3d34c11b1d85c656889ed17::bee {
    struct BEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEE>(arg0, 9, b"BEE", b"Bee", b"$BEE for the people. The sweetest token on Sui. Our community is bonded together with honey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1840352673620455424/SOPkojuE_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BEE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

