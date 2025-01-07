module 0xc2c9c15ca0f8e69021fb39b803d8fad00932765e924b57a1d51b7a70bd4de840::fomo {
    struct FOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMO>(arg0, 6, b"FOMO", b"FOMO Panda", b"FOMO Panda ($FOMO) is a meme token on the SUI blockchain, designed for those who fear missing out on great opportunities! Inspired by the FOMO (Fear of Missing Out) concept, our token encourages users to quickly join the project and earn unique rewards. With each new participant, $FOMO becomes even more valuable, driving the community towards active engagement, as no one wants to be left \"out of the loop\" in the crypto revolution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_20210607174826_8cc8ee3303.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

