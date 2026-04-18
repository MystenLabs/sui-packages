module 0xc1700f17fb999cf98ac7940ee4cc6b265238036fb894004233c5cb193e31fbf2::Bazaar {
    struct Vault has copy, drop {
        supply_id: u64,
        patarian_id: u64,
        phantom_addr: address,
        coin_no: u8,
        amount: u64,
        group_no: u16,
        type_no: u16,
        quantity: u64,
        proof: u64,
    }

    struct Claimon has copy, drop {
        patarian_id: u64,
        supply_id: u64,
        phantom_addr: address,
        coin_no: u8,
        amount: u64,
        commission: u64,
        proof: u64,
    }

    public fun Mint(arg0: u64, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Claimon{
            patarian_id  : arg0,
            supply_id    : arg1,
            phantom_addr : 0x2::tx_context::sender(arg6),
            coin_no      : arg2,
            amount       : arg3,
            commission   : arg4,
            proof        : arg5,
        };
        0x2::event::emit<Claimon>(v0);
    }

    public fun Supply(arg0: u64, arg1: u64, arg2: u64, arg3: u8, arg4: u16, arg5: u16, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            supply_id    : arg0,
            patarian_id  : arg1,
            phantom_addr : 0x2::tx_context::sender(arg8),
            coin_no      : arg3,
            amount       : arg2,
            group_no     : arg4,
            type_no      : arg5,
            quantity     : arg6,
            proof        : arg7,
        };
        0x2::event::emit<Vault>(v0);
    }

    // decompiled from Move bytecode v6
}

