module 0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::dwl {
    struct DWL has drop {
        dummy_field: bool,
    }

    public fun buy_dwl(arg0: &mut 0x2::coin::TreasuryCap<DWL>, arg1: &0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::GameConfig, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::assert_version(arg1);
        0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::assert_not_paused(arg1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = (((v0 as u128) * (0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::dwl_per_sui(arg1) as u128) / 1000000000) as u64);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::treasury_address(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<DWL>>(0x2::coin::mint<DWL>(arg0, v1, arg3), 0x2::tx_context::sender(arg3));
        0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::events::emit_dwl_purchased(0x2::tx_context::sender(arg3), v0, v1);
    }

    fun init(arg0: DWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWL>(arg0, 9, b"DWL", b"DigiWorld Live", b"In-game currency for DigiWorld Live", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

