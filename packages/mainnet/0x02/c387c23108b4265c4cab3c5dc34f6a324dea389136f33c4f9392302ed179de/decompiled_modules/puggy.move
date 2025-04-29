module 0x2c387c23108b4265c4cab3c5dc34f6a324dea389136f33c4f9392302ed179de::puggy {
    struct PUGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGGY>(arg0, 6, b"Puggy", b"Puggydog", b"First dog on moobag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiflvz3ey5vg2fpmiicc2y3ncmquyiw77vm3zdoqllf6oskqp2nhou")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUGGY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

