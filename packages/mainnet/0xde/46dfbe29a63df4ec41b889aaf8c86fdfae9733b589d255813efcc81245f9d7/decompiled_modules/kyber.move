module 0xde46dfbe29a63df4ec41b889aaf8c86fdfae9733b589d255813efcc81245f9d7::kyber {
    struct KYBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: KYBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYBER>(arg0, 6, b"kyber", b"kyber", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmX534aJqhguTuKUW75w6ibDkDmZiLyre81VrPccSzALGc?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KYBER>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYBER>>(v2, @0xb264f2c3812e3da7b1b1e7c4ed941fdd972b0c01561587b8b37d81625c9a51cd);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KYBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

