module 0xf52cfbf69633cdf4e5b69e2e14910e62f2c10e8799612bffe177f21c5c451f6d::genki {
    struct GENKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENKI>(arg0, 6, b"Genki", b"Genki on Sui", b"$Genki is not just a meme token; its a movement! Inspired by the Japanese word for energy and vitality, $Genki is here to bring fun, excitement, and a fresh burst of life to the Sui blockchain. With a community-first approach, $Genki is designed to make crypto enjoyable again, combining humor, culture, and viral energy into one explosive token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4194_50de0aeede.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

