module 0xcb9be351ffd5827217e15ed0b08ec541994798a0ca7bc3ab5172236d0a9e005c::aasui {
    struct AASUI has drop {
        dummy_field: bool,
    }

    public entry fun disable_minting(arg0: 0x2::coin::TreasuryCap<AASUI>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AASUI>>(arg0, @0x0);
    }

    fun init(arg0: AASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AASUI>(arg0, 9, b"AASUI", b"Aura Aqua Sui", b"Bathed in Aqua Aura light, this blue gorilla dances with the wild soul of the Sui chain, a playful spirit woven from liquid code and cosmic memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/gigagfun/Pepeonsui/refs/heads/main/AquaApedofsuiaura.jpeg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AASUI>>(0x2::coin::mint<AASUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AASUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

