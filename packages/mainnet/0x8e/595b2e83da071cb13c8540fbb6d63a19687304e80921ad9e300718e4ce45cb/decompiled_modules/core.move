module 0x8e595b2e83da071cb13c8540fbb6d63a19687304e80921ad9e300718e4ce45cb::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORE>(arg0, 6, b"Core", b"SatoshiCore", x"4275696c74206f6e207468652076616c756573206f66207472616e73706172656e63792c20646563656e7472616c697a6174696f6e2c20616e642074727573742c0a5361746f73686920436f696e20636172726965732074686520746f72636820696e746f2061206e657720657261206f66206469676974616c207765616c74682e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiexnt4wi4svjy64sthvopd3qw67jaiuxhyvdhc223ietbpbsfyloy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CORE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

