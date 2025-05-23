module 0x210abbcf9ad5753fc7bb39b62bf4c2c256be227ce76fb7876788dc66c8633911::brett {
    struct BRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETT>(arg0, 6, b"BRETT", b"B.R.E.T.T", b"Buy, Retain, Enjoy The Token is a simple way to invest in cryptocurrency. First, you buy the token, then hold onto it as it grows in value, and finally, enjoy the rewards of being part of a supportive community. With $BRETT, you're not just investing; you're joining a group that values patience and steady growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_02_28_54_54ffbb37cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

