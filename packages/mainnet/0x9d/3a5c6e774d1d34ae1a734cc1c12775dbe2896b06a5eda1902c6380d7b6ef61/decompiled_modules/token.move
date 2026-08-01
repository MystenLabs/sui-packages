module 0x9d3a5c6e774d1d34ae1a734cc1c12775dbe2896b06a5eda1902c6380d7b6ef61::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: 0x2::coin::Coin<TOKEN>) {
        0x2::coin::burn<TOKEN>(arg0, arg1);
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"dblm66", x"e68993e4babae4b893e794a8", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ivory-far-raccoon-520.mypinata.cloud/ipfs/bafkreietc2ok5kshsxwu7nmbppg5ltmv3j7lgwecqvmhy36tc3e2btljay?pinataGatewayToken=OrWLwk4RoZSpAeYDabvcxh5-LBoWyF5K3KxkleIkomXjXMxMuZvjrLdweldmxT7_")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(0x2::coin::mint<TOKEN>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

