module 0x7a909eb6c042c3adc45fc2308819e91099814264099b5f5c3051bcc481181011::rigby {
    struct RIGBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIGBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIGBY>(arg0, 6, b"Rigby", b"Rigby On Sui", b"Meet Rigby, the internets favorite slacker-turned-crypto-hero. inspired by his unpredictable energy and chaotic humor, this project brings the meme culture of Rigby into the decentralized world. powered by blockchain tech and a community of believers, Rigby is here to make waves, not rules.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tokenomic_Img2_399e3cc3_1_c8f985d656.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIGBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIGBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

