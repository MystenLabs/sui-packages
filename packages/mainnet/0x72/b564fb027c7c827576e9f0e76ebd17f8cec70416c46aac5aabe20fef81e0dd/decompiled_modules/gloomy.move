module 0x72b564fb027c7c827576e9f0e76ebd17f8cec70416c46aac5aabe20fef81e0dd::gloomy {
    struct GLOOMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOOMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOOMY>(arg0, 9, b"Gloomy", b"Gloomy Coin", b"Gloomy Coin is the official currency of Gloomy Pal store. Gloomy Pal is an emotional plushie, that has gained over 2+ Million followers and over 1 Billion video views!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTh5Qpdnrm7WMqyV8MhSK4aeftpjjaZ82BBWbHvFTfwZv")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GLOOMY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLOOMY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOOMY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

