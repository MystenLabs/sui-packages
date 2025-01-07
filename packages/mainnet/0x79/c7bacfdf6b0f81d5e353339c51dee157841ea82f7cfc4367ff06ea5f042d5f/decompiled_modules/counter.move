module 0x79c7bacfdf6b0f81d5e353339c51dee157841ea82f7cfc4367ff06ea5f042d5f::counter {
    struct HELLO_COIN has drop {
        dummy_field: bool,
    }

    struct TreasuryCapStorage has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<HELLO_COIN>,
    }

    // decompiled from Move bytecode v6
}

