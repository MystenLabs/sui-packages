module 0xc40725e5e1c443961f1bc08059cbe67f1e45f3bc382abc47fd137b85038ae1a5::space_pepe {
    struct SPACEPEPE has key {
        id: 0x2::object::UID,
    }

    struct SPACEPEPEGenerationCap has key {
        id: 0x2::object::UID,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SPACEPEPE>, arg1: 0x2::coin::Coin<SPACEPEPE>) {
        0x2::coin::burn<SPACEPEPE>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SPACEPEPE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SPACEPEPE>>(0x2::coin::mint<SPACEPEPE>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun create(arg0: &SPACEPEPEGenerationCap, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<SPACEPEPE>(arg1, 0, 0x1::string::utf8(b"SPPE"), 0x1::string::utf8(b"Space Pepe"), 0x1::string::utf8(b"We choose to go to Mars"), 0x1::string::utf8(b"https://arweave.net/LDuUjk42LhcMo_Im7d0eCSadplg8AG7HhND9RjY49d0"), arg2);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SPACEPEPE>>(0x2::coin_registry::finalize<SPACEPEPE>(v0, arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACEPEPE>>(v2, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<SPACEPEPE>>(0x2::coin::mint<SPACEPEPE>(&mut v2, 1000000, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SPACEPEPEGenerationCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SPACEPEPEGenerationCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

