module 0x4362af3de3dc5824d950ee8a4e54a37311a6a42a91538c79b90b4f435394c28c::kraken {
    struct KRAKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRAKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRAKEN>(arg0, 6, b"KRAKEN", b"Sui Kraken", x"52656c656173696e672074686520537569204b72616b656e20282452414b454e2920546865206d6967687479204b72616b656e206f66205375690a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zodiac000z_rpg_item_icon_of_a_krakenlooking_arrogantshowing_off_3c026688_0c88_4d3e_9729_a795bf08bc98_1_9f543e2194_8e067a1eae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRAKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRAKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

