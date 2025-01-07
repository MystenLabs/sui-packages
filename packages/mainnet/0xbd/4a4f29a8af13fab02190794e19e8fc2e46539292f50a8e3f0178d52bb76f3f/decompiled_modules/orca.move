module 0xbd4a4f29a8af13fab02190794e19e8fc2e46539292f50a8e3f0178d52bb76f3f::orca {
    struct ORCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCA>(arg0, 6, b"ORCA", b"Sui Orca", b"The oceans apex predator meets the power of Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zodiac000z_rpg_item_icon_of_a_cute_orcaconcept_artart_gamecreat_c139f65b_7e17_4b93_b9af_693ed82e355f_fb2f5d5b06.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

