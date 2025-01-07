module 0x3ae1b901b3dc4c0c28a77817f433485e44fc7b6fdacc68ac91f011deb2439db5::suimm {
    struct SUIMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMM>(arg0, 6, b"SUIMM", b"SUI MICKEY MOUSE", b"Community Token of web3 on Sui, Mickey Mouse is no longer a Disney Mascot and gained freedom since 1928, Mickey Mouse now belongs to the Community lets make SUI Home to mickey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DP_2_347a1f2ab5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

