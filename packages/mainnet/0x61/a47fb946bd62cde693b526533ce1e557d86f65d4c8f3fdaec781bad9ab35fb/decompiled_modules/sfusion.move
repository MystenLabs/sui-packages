module 0x61a47fb946bd62cde693b526533ce1e557d86f65d4c8f3fdaec781bad9ab35fb::sfusion {
    struct SFUSION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFUSION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFUSION>(arg0, 6, b"SFusion", b"SuiFusion", b"SuiFusion is a community-driven meme token on the Sui blockchain, designed to bring investors together and create a powerful fusion of growth and innovation. With a vision of synergy and strong community bonds, SuiFusion aims to be a leading force in the Sui ecosystem, delivering rewards and opportunities for all holders. Join the fusion and ride the wave of success!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_CD_9559_A_8665_481_A_AFF_6_97_D9128_A1_ACF_0c41339450.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFUSION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFUSION>>(v1);
    }

    // decompiled from Move bytecode v6
}

