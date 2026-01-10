module 0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon {
    struct PUIMON has key {
        id: 0x2::object::UID,
    }

    struct PUIGenerationCap has key {
        id: 0x2::object::UID,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PUIMON>, arg1: 0x2::coin::Coin<PUIMON>) {
        0x2::coin::burn<PUIMON>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PUIMON>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PUIMON>>(0x2::coin::mint<PUIMON>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun create(arg0: &PUIGenerationCap, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<PUIMON>(arg1, 0, 0x1::string::utf8(b"PUIMON"), 0x1::string::utf8(b"Pui Monster"), 0x1::string::utf8(b"Second generation of PUI coin"), 0x1::string::utf8(b"https://arweave.net/g2Fgf9YlkDv6B4YD0AZPZjcelUCmntk-jVEt28VzJVU"), arg2);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PUIMON>>(0x2::coin_registry::finalize<PUIMON>(v0, arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUIMON>>(v2, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<PUIMON>>(0x2::coin::mint<PUIMON>(&mut v2, 100000000, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PUIGenerationCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PUIGenerationCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

