module 0xabced4792e1ad37bb1d4bfbe36dcd391b3ed8778b4e91dd9d0cf9192e58bbd4a::XYLEG {
    struct XYLEG has drop {
        dummy_field: bool,
    }

    struct XYLEG_Supply has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<XYLEG>,
    }

    fun init(arg0: XYLEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<XYLEG>(arg0, 9, 0x1::string::utf8(b"XYLEG"), 0x1::string::utf8(b"XYLE Governance Token"), 0x1::string::utf8(b"Governance token for XYLE DAO"), 0x1::string::utf8(b""), arg1);
        let v2 = 0x2::coin::treasury_into_supply<XYLEG>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<XYLEG>>(0x2::coin::from_balance<XYLEG>(0x2::balance::increase_supply<XYLEG>(&mut v2, 3800000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = XYLEG_Supply{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::public_transfer<XYLEG_Supply>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<XYLEG>>(0x2::coin_registry::finalize<XYLEG>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint_from_supply(arg0: &mut XYLEG_Supply, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<XYLEG>>(0x2::coin::from_balance<XYLEG>(0x2::balance::increase_supply<XYLEG>(&mut arg0.supply, arg1), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

