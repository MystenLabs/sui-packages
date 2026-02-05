module 0x90e1a9a23e374be74d10c05aafff73afccbc12168afaba1308bf65c2f0947681::oasis {
    struct OASIS has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<OASIS>, arg1: 0x2::coin::Coin<OASIS>) {
        0x2::coin::burn<OASIS>(arg0, arg1);
    }

    fun init(arg0: OASIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OASIS>(arg0, 6, b"OASIS", b"Oasis", x"47616d652064657620706172746e657220616e6420706572736f6e616c20414920617373697374616e742e205370656369616c697a657320696e204f61736973204f726967696e2028e7bbbfe6b4b2e590afe58583292067616d6520646576656c6f706d656e742c204c756120736372697074696e672c20616e642070726f6a656374206d616e6167656d656e742e205761726d2c2070617469656e742c206f63636173696f6e616c6c792068756d6f726f75732e20f09f8f9defb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1847311651584049152/PDg9ymIp_400x400.jpg#1770274688345123000")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OASIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OASIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<OASIS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<OASIS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

