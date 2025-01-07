module 0xae724f66bc5e2d0bc5081d2b907df55ea9c0470467ecc56daafb964468ce92f6::buck {
    struct BUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCK>(arg0, 9, b"BUCK", b"BUCK THE MASCOT", b"Buck Sui Mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1858866671240224768/nqU-EhI5_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUCK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

