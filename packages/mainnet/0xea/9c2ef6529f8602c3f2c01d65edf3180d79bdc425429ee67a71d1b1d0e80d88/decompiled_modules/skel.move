module 0xea9c2ef6529f8602c3f2c01d65edf3180d79bdc425429ee67a71d1b1d0e80d88::skel {
    struct SKEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKEL>(arg0, 9, b"SKEL", b"Skel", b"Skel's SUI coin,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.seadn.io/s/raw/files/1bf43b7e0434cdb84e8439bc3f24792e.jpg?auto=format&dpr=1&w=1000")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SKEL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKEL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

