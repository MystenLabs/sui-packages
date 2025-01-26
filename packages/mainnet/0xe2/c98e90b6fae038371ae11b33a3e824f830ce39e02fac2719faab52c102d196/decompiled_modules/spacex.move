module 0xe2c98e90b6fae038371ae11b33a3e824f830ce39e02fac2719faab52c102d196::spacex {
    struct SPACEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPACEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPACEX>(arg0, 9, b"SPACEX", b"SpaceX", b"This is Space X token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZiy4AjCp59RtRZxxFjV17QNYKuYVeqv2UPE5S57jUCDC")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPACEX>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACEX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPACEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

