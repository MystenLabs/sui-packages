module 0xaaa0c7f74f8e0809c731ea2a8364ecdaee60b64411e272b3a9a07852c272183f::pogi {
    struct POGI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<POGI>, arg1: 0x2::coin::Coin<POGI>) {
        0x2::coin::burn<POGI>(arg0, arg1);
    }

    fun init(arg0: POGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<POGI>(arg0, 6, b"POGI", x"546164656a20506f6761c48d6172", b"World Road Cycling Champion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://upload.wikimedia.org/wikipedia/commons/a/a6/Tadej_Pogacar_winning_the_Giro_dell%27Emilia_on_October_5th_2024.jpg"))), false, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<POGI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POGI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<POGI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<POGI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

