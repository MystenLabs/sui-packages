module 0xa1a7240047dde495d1235d49ac6eb9bef825f4af88370e19bf72c34978579fd4::fock {
    struct FOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOCK>(arg0, 6, b"FOCK", b"FOCKING MARKET", x"45564552594f4e4527532043484153494e47204e554d424552532c2042555420574520415245204f555420484552452043484153494e47205649424553210a0a534f2e2e2e2057485920444f4e275420594f5520464f434b2041524f554e4420574954482055533f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigaetr55lex3cokg7bqltdcl6tghug4se4pyuhuk36qdi4yfazg2u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FOCK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

