module 0x310ad4e8bed27620f44d4fc9df6ce927a4e20c10ad35cd3d3f50234085ac6f5d::suiordi {
    struct SUIORDI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIORDI>, arg1: 0x2::coin::Coin<SUIORDI>) {
        0x2::coin::burn<SUIORDI>(arg0, arg1);
    }

    public entry fun give_up_permission(arg0: 0x2::coin::TreasuryCap<SUIORDI>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIORDI>>(arg0, 0x2::address::from_u256(0));
    }

    fun init(arg0: SUIORDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIORDI>(arg0, 2, b"Sui Ordi", b"Sui Ordi", b"sui ordi is the ordinals clone on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.gate.io/images/coin_icon/64/ordi.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIORDI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIORDI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIORDI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIORDI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

