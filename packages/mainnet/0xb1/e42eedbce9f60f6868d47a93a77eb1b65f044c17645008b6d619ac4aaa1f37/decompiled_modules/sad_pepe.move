module 0xb1e42eedbce9f60f6868d47a93a77eb1b65f044c17645008b6d619ac4aaa1f37::sad_pepe {
    struct SAD_PEPE has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SAD_PEPE>, arg1: 0x2::coin::Coin<SAD_PEPE>) {
        0x2::coin::burn<SAD_PEPE>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SAD_PEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SAD_PEPE>>(0x2::coin::mint<SAD_PEPE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SAD_PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SAD_PEPE>(arg0, 6, 0x1::string::utf8(b"SADPE"), 0x1::string::utf8(b"Sad Pepe"), 0x1::string::utf8(b"Community meme coin for sad frogs"), 0x1::string::utf8(b"https://i.imgur.com/your_pepe_icon.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAD_PEPE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SAD_PEPE>>(0x2::coin_registry::finalize<SAD_PEPE>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

