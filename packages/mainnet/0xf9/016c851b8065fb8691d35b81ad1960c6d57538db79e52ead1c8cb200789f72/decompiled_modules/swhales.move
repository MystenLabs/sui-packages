module 0xf9016c851b8065fb8691d35b81ad1960c6d57538db79e52ead1c8cb200789f72::swhales {
    struct SWHALES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWHALES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWHALES>(arg0, 6, b"SWhales", b"SuiWhales", b"SuiWhales is a community-driven meme token on the Sui blockchain, celebrating the power of crypto whales. It aims to create a fun, engaging, and rewarding ecosystem where users can ride the waves of innovation and crypto success. Dive into the SuiWhales experience and join the pod!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000369_fa5f60585b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWHALES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWHALES>>(v1);
    }

    // decompiled from Move bytecode v6
}

