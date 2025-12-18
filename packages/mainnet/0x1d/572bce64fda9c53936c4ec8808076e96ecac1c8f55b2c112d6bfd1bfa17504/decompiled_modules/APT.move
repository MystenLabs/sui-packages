module 0x1d572bce64fda9c53936c4ec8808076e96ecac1c8f55b2c112d6bfd1bfa17504::APT {
    struct APT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<APT>, arg1: 0x2::coin::Coin<APT>) {
        0x2::coin::burn<APT>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<APT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<APT> {
        0x2::coin::mint<APT>(arg0, arg1, arg2)
    }

    fun init(arg0: APT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APT>(arg0, 9, b"APT", b"Adapt", b"Adapt ANP3 aims to become the \"HTTP\" standard for agent-to-agent interaction...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://adapt-anp3.ai/logo.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APT>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<APT>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<APT> {
        assert!(0x2::coin::total_supply<APT>(arg0) + 1000000000000000000 <= 1000000000000000000, 0);
        0x2::coin::mint<APT>(arg0, 1000000000000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

