module 0x2e95df16acfa3c7208db7d70133d7f56ffb320f72405b1ab0ff02b16b57d2ecf::GOAT {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 6, b"Greatest Of All Token", b"GOAT", x"41206d656d6520636f696e2063656c6562726174696e672074686520474f415473206f662074686520776f726c64e28094776865746865722074686579277265206c6567656e64617279206174686c657465732c2069636f6e696320696e666c75656e636572732c206f72206a75737420796f7572206661766f726974652070657420676f61742e2052696465207468652077617665206f662067726561746e657373207769746820474f415420746f6b656e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/P4T80OirIg5sEhDEtHAeqfhvd2aDyxyK6VM5C3JIqf6z39LqA/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v0, @0x2be6c850562754e11af55b7f049f4e304e488dff630b3832874d80c837c458a8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

