module 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::fees {
    struct Fees has copy, drop, store {
        fee: u64,
        recipient: address,
    }

    public fun fee(arg0: &Fees, arg1: u64) : u64 {
        arg1 * arg0.fee / 100
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: address) : Fees {
        Fees{
            fee       : arg0 * arg1,
            recipient : arg2,
        }
    }

    public(friend) fun pay(arg0: &Fees, arg1: u64, arg2: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg2, fee(arg0, arg1)), arg3), arg0.recipient);
    }

    public(friend) fun set_fees(arg0: &mut Fees, arg1: u64, arg2: u64) {
        arg0.fee = arg1 * arg2;
    }

    public(friend) fun set_recipient(arg0: &mut Fees, arg1: address) {
        arg0.recipient = arg1;
    }

    // decompiled from Move bytecode v6
}

