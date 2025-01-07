module 0xab1600c2cad0b57b9c4207974bd2dafd0cc817a4a54b6b9d9d5a9c7b98a4eda5::raja {
    struct RAJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAJA>(arg0, 6, b"RAJA", b"raja on top sui", b"raja on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.seadn.io/gcs/files/cd28aa87caf2af70b53c1767538edab7.png?auto=format&dpr=1&w=1000")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RAJA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAJA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAJA>>(v1);
    }

    // decompiled from Move bytecode v6
}

