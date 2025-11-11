module 0xabced4792e1ad37bb1d4bfbe36dcd391b3ed8778b4e91dd9d0cf9192e58bbd4a::XYLE {
    struct XYLE has drop {
        dummy_field: bool,
    }

    struct XYLE_Supply has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<XYLE>,
    }

    fun init(arg0: XYLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<XYLE>(arg0, 9, 0x1::string::utf8(b"XYLE"), 0x1::string::utf8(b"XYLE Token"), 0x1::string::utf8(b"Utility token for XYLE ecosystem"), 0x1::string::utf8(b""), arg1);
        let v2 = XYLE_Supply{
            id     : 0x2::object::new(arg1),
            supply : 0x2::coin::treasury_into_supply<XYLE>(v1),
        };
        0x2::transfer::public_transfer<XYLE_Supply>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<XYLE>>(0x2::coin_registry::finalize<XYLE>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint_from_supply(arg0: &mut XYLE_Supply, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<XYLE>>(0x2::coin::from_balance<XYLE>(0x2::balance::increase_supply<XYLE>(&mut arg0.supply, arg1), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

