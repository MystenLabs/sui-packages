module 0x5396c55a8a7982a99de86168c1f703633784335d301edf5c0569614df28402f8::wifcash {
    struct WIFCASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFCASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFCASH>(arg0, 6, b"WIFCASH", b"Dogwifcash", b"DogWifCash has recently advertised on DEX Screener!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmXk5NsLLbQtDcKD46Hj8J6ifqgREgeVKXkWzLPvj9eciX?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WIFCASH>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFCASH>>(v2, @0x236aa176e48b5d14bcc28a674c1eb01ccde386f70f737346949577e0228e3f6f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFCASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

