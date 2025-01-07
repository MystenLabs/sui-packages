module 0x7874f0a13093fd2c897aca0c16da72028f8b8dd8592bb958e5a4784b42d0e4be::bibi {
    struct BIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIBI>(arg0, 6, b"BIBI", b"BIBITOKEN", b"BIBI is a new Web3 ecosystem that is completely driven by the community. It focuses on the spread of MEME culture and the construction of Web3 communities, aiming to build a creative, interactive and controlled learning community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUNBIBI_TG_To_B8_6tsoy62qt_Y_Ez_b15652e561.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

