module 0x96207da6d02bf1e94eddc5de13768ce01f11b3301111a1a607c834c8aa8819eb::bausd {
    struct BAUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAUSD>(arg0, 9, b"BAUSD", b"BAUSD", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreifxrule7hq3tox267qohrw4wtazcyxubguoyanpktx3iscjgi4sni")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BAUSD>>(0x2::coin::mint<BAUSD>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAUSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAUSD>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

