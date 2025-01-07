module 0xb9ea0dd8a9f48d875c3e528eb37ce1307c9e777c54e6ef95e967ac1e9b4c6392::pmdeng {
    struct PMDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PMDENG>(arg0, 9, b"PMDeng", b"Pixel Moo Deng", x"22506978656c204d6f6f2044656e67206d616b65732061206772616e6420656e7472616e636520696e746f2074686520776f726c64206f6620537569204e6574776f726b2c20737472617070696e67206f6e2069747320646f6c6c61722d6675656c656420726f636b65742e2e2e20616e642061696d7320737472616967687420666f7220746865206d6f6f6e2120f09f9a80f09f92b822", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://x.com/i/status/1840561807934865594")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PMDENG>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMDENG>>(v2, @0xc8ef93246169a8da20d3824e902323b593de2967b32c5e7d34cabc9a35006b3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PMDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

