module 0x30503d06edd490cee3b48873958927c8c0a74ba37cbbfa7ace97f8485912e03f::owldough {
    struct OWLDOUGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWLDOUGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWLDOUGH>(arg0, 9, b"OWLDOUGH", b"Owldough", x"57686f3f2057686f3f2057686f2773206d616b696e67206761696e733f204f776c646f756768277320776973646f6d207475726e73206c6174652d6e696768742074726164657320696e746f206d6f726e696e6720676f6c64e28094776974682077696465206579657320616e642077696465722070726f666974732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreicl4n26yoxjlmrwh4qff5ffwdbwnsesylcreyvk2655sp374v2p3m")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OWLDOUGH>(&mut v2, 1000000000000000000, @0x86428776defb6b37e4039efdd64fb1284e144171ea5b7b6821ab171043731cce, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWLDOUGH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OWLDOUGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

