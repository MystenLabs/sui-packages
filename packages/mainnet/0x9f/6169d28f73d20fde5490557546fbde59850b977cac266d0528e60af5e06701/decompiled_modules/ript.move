module 0x9f6169d28f73d20fde5490557546fbde59850b977cac266d0528e60af5e06701::ript {
    struct RIPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIPT>(arg0, 6, b"RIPT", b"RIPTOS", b"Spooky Suizon started early here on the Sui Network. We just flipped Aptos into an early grave. Can we give them a new lease of life -- The quest of resurrection begins! $RIPT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_necromancer_resurrecting_a_digital_coin_from_the_grave_coming_out_of_the_ground_green_black_ne_izy1k21oot27u5j19suu_2_3e4b912072.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

