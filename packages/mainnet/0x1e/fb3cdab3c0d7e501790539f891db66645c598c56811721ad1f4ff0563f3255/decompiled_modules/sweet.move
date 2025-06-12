module 0x1efb3cdab3c0d7e501790539f891db66645c598c56811721ad1f4ff0563f3255::sweet {
    struct SWEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWEET>(arg0, 9, b"SWEET", b"Sweet", b"The sweetest wallet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.sweetwallet.app/token.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SWEET>(&mut v2, 20000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWEET>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWEET>>(v1);
    }

    // decompiled from Move bytecode v6
}

