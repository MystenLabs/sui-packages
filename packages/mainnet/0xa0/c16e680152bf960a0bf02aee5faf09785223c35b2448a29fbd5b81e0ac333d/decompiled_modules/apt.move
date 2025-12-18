module 0xa0c16e680152bf960a0bf02aee5faf09785223c35b2448a29fbd5b81e0ac333d::apt {
    struct APT has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<APT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<APT>(arg0) + arg1 <= 1000000000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<APT>>(0x2::coin::mint<APT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: APT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APT>(arg0, 9, b"APT", b"Adapt", b"Adapt ANP3 aims to become the \"HTTP\" standard for agent-to-agent interaction...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://adapt-anp3.ai/logo.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

