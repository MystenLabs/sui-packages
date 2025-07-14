module 0x59917d4483b9bd61a214e099f2483e2171b89ae5050a81516becdc9d198659d0::folanijustfortest {
    struct FOLANIJUSTFORTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOLANIJUSTFORTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOLANIJUSTFORTEST>(arg0, 6, b"FOLANIjustForTest", b"FOLANI", b"Web3 and Crypto enthusiast", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigvegfuh7tpzrgogrvi45rstbzumcnueoxijrghpamsrvs7ucudzu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOLANIJUSTFORTEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FOLANIJUSTFORTEST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

