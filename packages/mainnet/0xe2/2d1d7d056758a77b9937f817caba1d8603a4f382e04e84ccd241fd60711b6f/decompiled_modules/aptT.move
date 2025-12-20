module 0xe22d1d7d056758a77b9937f817caba1d8603a4f382e04e84ccd241fd60711b6f::aptT {
    struct APTT has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<APTT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<APTT>(arg0) + arg1 <= 1000000000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<APTT>>(0x2::coin::mint<APTT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: APTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APTT>(arg0, 9, b"APT", b"Adapt", b"Adapt ANP3 aims to become the \"HTTP\" standard for agent-to-agent interaction...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://adapt-anp3.ai/logo.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APTT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APTT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

