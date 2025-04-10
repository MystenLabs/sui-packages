module 0x6b8a4b4c7e689afb2a05ff5f8d53adc61c40cfd1826a53600fe03d4cd033f81f::hjo {
    struct HJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HJO>(arg0, 6, b"HJO", b"Jolie ne", b"hsjflsjdlsk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreiez43lssgngn4aheerwio56a7v2mir224jzqypk7lptdbjqgfzsu4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HJO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

