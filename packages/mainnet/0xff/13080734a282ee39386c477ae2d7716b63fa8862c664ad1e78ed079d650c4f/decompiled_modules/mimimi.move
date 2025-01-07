module 0xff13080734a282ee39386c477ae2d7716b63fa8862c664ad1e78ed079d650c4f::mimimi {
    struct MIMIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIMIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIMIMI>(arg0, 6, b"MIMIMI", b"MIMIMI", b"No cap, MIMIMI is the real deal.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-bright-chinchilla-232.mypinata.cloud/ipfs/Qma2U1uBhR3DgG6FJKoY6rDk6bocAyrjrbVRogLCQjnXPo/icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIMIMI>>(v1);
        0x2::coin::mint_and_transfer<MIMIMI>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIMIMI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

