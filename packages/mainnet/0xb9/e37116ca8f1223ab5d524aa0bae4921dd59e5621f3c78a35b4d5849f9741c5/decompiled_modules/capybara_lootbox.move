module 0xb9e37116ca8f1223ab5d524aa0bae4921dd59e5621f3c78a35b4d5849f9741c5::capybara_lootbox {
    struct CAPYBARA_LOOTBOX has drop {
        dummy_field: bool,
    }

    struct NFTFruit has key {
        id: 0x2::object::UID,
        fruit_type: 0x1::string::String,
    }

    struct NFTLootbox has key {
        id: 0x2::object::UID,
    }

    struct KapybaraNFT has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: CAPYBARA_LOOTBOX, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

