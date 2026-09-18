module 0x6e585c8bc54750b07106f89206c0c57fff65d00fa6b90fce28584a6661961b41::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"044c4f4e47095368656e204c6f6e67e6015368656e6c6f6e672028e7a59ee9be993b20e7a59ee9be8d3b207368c3a96e206cc3b36e673b20e7a59ee9be8d2c207368696e7279c5ab29206c69746572616c6c792022676f6420647261676f6e22206f722022646976696e6520647261676f6e22206973207468652073706972697420647261676f6e2066726f6d204368696e657365206d7974686f6c6f67792077686f2069732074686520647261676f6e20676f64206f66207468652074656d7065737420616e6420616c736f2061206d6173746572206f66207261696e2e204c65742773206d616b65206974207261696e205375692e4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f30613663653630363062306233373535623134356233656637633632616530302e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

