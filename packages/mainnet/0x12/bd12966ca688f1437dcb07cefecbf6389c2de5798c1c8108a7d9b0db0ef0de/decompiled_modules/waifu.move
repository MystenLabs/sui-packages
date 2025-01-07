module 0x12bd12966ca688f1437dcb07cefecbf6389c2de5798c1c8108a7d9b0db0ef0de::waifu {
    struct WAIFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAIFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAIFU>(arg0, 6, b"WAIFU", b"Sui Waifu", b"Your dream girl has arrived. $WAIFU is here to sweep the Sui Network off its feet. Beautiful, dedicated, and always there to support. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zodiac000z_rpg_item_icon_of_a_chibi_anime_girlholds_moneyfull_b_c3d9da8d_ba88_43d4_b85a_c97befae4610_9ad52f80ae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAIFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAIFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

