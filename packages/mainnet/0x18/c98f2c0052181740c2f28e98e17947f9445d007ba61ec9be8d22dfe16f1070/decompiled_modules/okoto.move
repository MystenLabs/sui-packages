module 0x18c98f2c0052181740c2f28e98e17947f9445d007ba61ec9be8d22dfe16f1070::okoto {
    struct OKOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OKOTO>(arg0, 6, b"OkotO", b"real k0t0", b"250B k0t0 for my", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmScgrVnZvvtDCvy5UmwfBHydxnFwahDfcjwa8fE6SpBev?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OKOTO>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKOTO>>(v2, @0x3c38f1ebdcd9ff0458b04ab1f7e4ccf30c11d51f571447ab6414d0ed3ca0517f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OKOTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

