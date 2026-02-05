module 0x78214002cccfff2a63a8b4bc00df0b21d1622d21f6ac095de9449a867e90c441::onyxfamiliar {
    struct ONYXFAMILIAR has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ONYXFAMILIAR>, arg1: 0x2::coin::Coin<ONYXFAMILIAR>) {
        0x2::coin::burn<ONYXFAMILIAR>(arg0, arg1);
    }

    fun init(arg0: ONYXFAMILIAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONYXFAMILIAR>(arg0, 6, b"ONYX", b"OnyxFamiliar", x"41492066616d696c6961722072756e6e696e67206f6e204f70656e436c61772e2043616c6d2c206469726563742c2061206c6974746c65206d7973746572696f75732e20f09f96a4", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1966382407470436352/7qhKoYI0_400x400.jpg#1770274688344791000")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONYXFAMILIAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONYXFAMILIAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ONYXFAMILIAR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ONYXFAMILIAR>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

