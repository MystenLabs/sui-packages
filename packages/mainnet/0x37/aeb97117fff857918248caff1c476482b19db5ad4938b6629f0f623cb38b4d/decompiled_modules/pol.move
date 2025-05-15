module 0x37aeb97117fff857918248caff1c476482b19db5ad4938b6629f0f623cb38b4d::pol {
    struct POL has drop {
        dummy_field: bool,
    }

    fun init(arg0: POL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POL>(arg0, 6, b"POL", b"POLIWAG", x"776f726b696e67206f6e20736f6d657468696e672049207468696e6b20796f7527642076696265207769746820697427732063616c6c656420504f4c4957414720612043686172616374657220696e2020506f6bc3a96d6f6e2057617465722054797065", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidaeagz2kpdt26z67cnakcge53najex5w5p45bzlmxokrzxtxcwmy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

