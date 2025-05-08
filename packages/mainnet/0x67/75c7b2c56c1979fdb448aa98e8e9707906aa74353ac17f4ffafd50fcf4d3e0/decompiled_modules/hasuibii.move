module 0x6775c7b2c56c1979fdb448aa98e8e9707906aa74353ac17f4ffafd50fcf4d3e0::hasuibii {
    struct HASUIBII has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASUIBII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASUIBII>(arg0, 6, b"HASUIBII", b"Hasuibi", b"haf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigbzhvsi2dt3tlaegbqouhz3lfzo2aaopcggdebvujpwo5uagvrnq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASUIBII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HASUIBII>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

