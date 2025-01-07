module 0x97e08675a241a9ab017c0aa6e4cce756976e2437fa7f2650fc7dff0deb9d0bd4::apug {
    struct APUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: APUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APUG>(arg0, 6, b"APUG", b"Aqua Pug", b"Aqua Pug (APUG) - Dive into the fun with this playful memecoin! APUG merges the adorable charm of pugs with the refreshing vibe of water, creating a splash in the Sui blockchain. Join a community of dog lovers and crypto enthusiasts in this meme-tastic adventure where fun meets finance. With a focus on community engagement, Aqua Pug aims to make waves through unique tokenomics, community events, and potential integrations into Sui's gaming ecosystem. Get ready to unleash joy, rewards, and possibly some good deeds with Aqua Pug!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_F2238_FD_0_BF_9_4_C8_E_BD_49_0_CDFF_5_EEA_484_947233caa2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

