module 0x15fe1f90e888a614302f41c180ac59a6dca8b558ff9de268d679960146f0d906::suitopus {
    struct SUITOPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOPUS>(arg0, 6, b"SUITOPUS", b"Sui Octopus", b"Meet Sui Octopus ($SUITOPUS), the smartest of the sea. This clever octopus is ready to navigate the deep waters of Sui, spreading its tentacles far and wide, and outsmarting everything in its path.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zodiac000z_rpg_item_icon_of_a_blue_octopusgolden_coin_eyescoins_32a05e2b_24dc_4c07_8b60_bd03395c3e0e_1_9123edb5f6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOPUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOPUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

