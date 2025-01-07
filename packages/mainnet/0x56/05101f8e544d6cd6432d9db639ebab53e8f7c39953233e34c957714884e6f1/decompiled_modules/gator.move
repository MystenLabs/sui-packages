module 0x5605101f8e544d6cd6432d9db639ebab53e8f7c39953233e34c957714884e6f1::gator {
    struct GATOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GATOR>(arg0, 6, b"GATOR", b"Suigator", b"$GATOR is a wild and fun community-driven meme coin on the SUI blockchain. Official - Unofficial movepump mascote. Inspired by the resilient and fierce spirit of alligators, $GATOR empowers its holders to thrive in the crypto swamp!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ga_Wo_No_RW_4_AA_Nn8_H_a0f92abdee.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GATOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GATOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

