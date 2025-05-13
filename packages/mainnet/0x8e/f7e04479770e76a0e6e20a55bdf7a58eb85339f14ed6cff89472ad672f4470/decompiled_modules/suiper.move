module 0x8ef7e04479770e76a0e6e20a55bdf7a58eb85339f14ed6cff89472ad672f4470::suiper {
    struct SUIPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPER>(arg0, 6, b"SUIPER", b"Suiperonsui", x"535549504552204953207468652076696272616e7420616e6420706c617966756c0a6865726f206f6620746865206469676974616c206167652c20626f726e2066726f6d0a74686520667573696f6e206f6620636f736d696320656e6572677920616e640a666c756964697479206f662077617465722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidn6rj2wziozgqjqfpythy5emg7z6i2a2sd75ip6yekcb3nipfz3a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIPER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

