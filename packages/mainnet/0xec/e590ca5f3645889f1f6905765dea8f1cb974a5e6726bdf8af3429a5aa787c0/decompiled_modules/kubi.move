module 0xece590ca5f3645889f1f6905765dea8f1cb974a5e6726bdf8af3429a5aa787c0::kubi {
    struct KUBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUBI>(arg0, 6, b"kubi", b"kyuubi", b"nine tails", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmUXtTAmXCjrhKMyoGvatEh8BMt8QzrQJGQh2RXKsNaSBh?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KUBI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUBI>>(v2, @0x3e89791033a66a9d8ec0bace7314852ac904314a3b4aa4c08fa286b76764148f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

