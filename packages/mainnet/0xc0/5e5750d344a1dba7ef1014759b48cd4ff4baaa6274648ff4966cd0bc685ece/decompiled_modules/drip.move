module 0xc05e5750d344a1dba7ef1014759b48cd4ff4baaa6274648ff4966cd0bc685ece::drip {
    struct DRIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRIP>(arg0, 9, b"DRIP", b"Drip", b"https://t.me/DRIPonSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/SQgCL1Qb/t0-OCTrba-400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DRIP>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRIP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

