module 0x6022329f2b47ecc106dfccb15ce5cd674e06ab628704ed334f988b6efdcf9027::buko {
    struct BUKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUKO>(arg0, 6, b"BUKO", b"Crypto Bukowski", b"Charles Bukowski in SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmYNJE7gQQeNDMWZxFDRDRVnizUSHX9kJ8MRkN4p4vmYzo?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUKO>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUKO>>(v2, @0xc0f4180e57665a1b8f172756b9c35fde22506b79db84a7b8f0f12fa6520b57a);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

