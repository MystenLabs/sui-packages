module 0xd242144fa38774a1433d88bad93bfe62ec51471644ca12b61b245206c28faff8::central {
    struct CENTRAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CENTRAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CENTRAL>(arg0, 6, b"Central", b"Centralised SUI Network", b"Sui is one  of the most centralised networks about , we know who you are and what you are doing, we are apart of the snakes in the cabal, we are fast and we are sly .... we hate freedom for people .; this is why SUi is Created ... SUI SUI SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_30_20_12_35_A_cartoon_style_image_of_a_cool_geeky_Chad_character_trading_cryptocurrency_at_his_desk_drawn_in_the_exaggerated_style_of_classic_cartoons_like_Ed_ae5c902825.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CENTRAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CENTRAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

