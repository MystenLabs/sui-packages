module 0x81d12281e28a5bc0f58a8684c69d613fd8f1af9d4889cb8943b9802f66dc940::trumph {
    struct TRUMPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPH>(arg0, 6, b"TRUMPH", b"TRUMPH SUI", b"$TRUMPh suiiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmWXSgFFMTuQhXcFGzvkgFh91rPEU5ahDqe5ueTzKVdsbF?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMPH>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPH>>(v2, @0xefb12062ffc2df750737378c5896f0794c228f1a3967f190c22d57111417cfbb);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPH>>(v1);
    }

    // decompiled from Move bytecode v6
}

