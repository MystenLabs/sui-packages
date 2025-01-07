module 0xe74af4981e4e446add1bb2702ee30c397bba31b6181c35662d8c6281d7872ded::suigun {
    struct SUIGUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGUN>(arg0, 9, b"SUIGUN", b"Sui Sniper Gun", b"Sui Sniper Gun : https://t.me/suiSniperGun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1843377294871789568/oRruf6I-.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGUN>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGUN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

