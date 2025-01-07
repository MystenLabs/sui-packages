module 0xc6b16f157adf075587f041fe4615a1872a93a0cbc899f044005e5c3e0a04b199::pol {
    struct POL has drop {
        dummy_field: bool,
    }

    fun init(arg0: POL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POL>(arg0, 9, b"POL", b"POLIMARDO", b"Polimardo buernardopolis", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/ext_tw_video_thumb/1808999012508262400/pu/img/gZ25LNdcRhm2wQDp.jpg:large")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POL>(&mut v2, 3000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POL>>(v1);
    }

    // decompiled from Move bytecode v6
}

