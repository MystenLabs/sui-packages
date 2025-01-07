module 0x71732e264c06102319114e6289e8ec00820568ca39c890d95200f24834e9e51f::suitopus {
    struct SUITOPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOPUS>(arg0, 6, b"SUITOPUS", b"Sui Octopus", b"The master of eight arms on Sui. SuiTopus grabs opportunities and never lets go.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zodiac000z_rpg_item_icon_of_a_blue_octopusgolden_coin_eyescoins_32a05e2b_24dc_4c07_8b60_bd03395c3e0e_25a4c0cf3e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOPUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOPUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

