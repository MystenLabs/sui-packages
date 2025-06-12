module 0xb06709dbddd79e5d6038e9a32dcd172712b8a65eb0faeeb6bf92662cb771d2c0::aaasd {
    struct AAASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAASD>(arg0, 6, b"AAAsd", b"Asad", b"aaaaasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibklyhgtiok6fqcv4y5i2plemuemzhxhrojulqgcmkpnpxdqsbokm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAASD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAASD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

