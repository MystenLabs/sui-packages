module 0xeda353dacead01fe9052605400b694d00542ae3b95aec1eb0a8b3e25fbeedde2::suijars {
    struct SUIJARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJARS>(arg0, 6, b"SuiJars", b"SUIJARS", b"SuiJars has evolved into a broader token-centric ecosystem, focusing on strategic utility and exclusive opportunities for token holders. By prioritizing access to vetted project IDOs, the initiative aims to empower participants and build a vibrant, engaged community. Leaderboards driven by criteria such as token HODLing, social engagement, and investment activities will unlock unique rewards. As the project progresses, NFTs will be introduced as a special recognition for the most dedicated contributors, serving as a symbol of their achievements and loyalty. This new direction reflects a tailored approach to meet the evolving interests of the crypto community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250122_030432_736_6d1e769a3a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

