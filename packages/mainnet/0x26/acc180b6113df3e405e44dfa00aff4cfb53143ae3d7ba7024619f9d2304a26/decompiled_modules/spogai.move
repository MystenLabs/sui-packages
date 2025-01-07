module 0x26acc180b6113df3e405e44dfa00aff4cfb53143ae3d7ba7024619f9d2304a26::spogai {
    struct SPOGAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SPOGAI>, arg1: 0x2::coin::Coin<SPOGAI>) {
        0x2::coin::burn<SPOGAI>(arg0, arg1);
    }

    public entry fun give_up_permission(arg0: 0x2::coin::TreasuryCap<SPOGAI>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOGAI>>(arg0, 0x2::address::from_u256(0));
    }

    fun init(arg0: SPOGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOGAI>(arg0, 2, b"SPOGAI", b"Sui Pogai", b"sui pogai is the first ecosystem focused meme coin on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.pogai.org/static/logo.8aefb4f6.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPOGAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOGAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SPOGAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SPOGAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

