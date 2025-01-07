module 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::final_winner {
    struct Mint has copy, drop {
        id: 0x2::object::ID,
        winner: address,
        shares: u64,
    }

    struct Claim has copy, drop {
        id: 0x2::object::ID,
        shares: u64,
    }

    struct FINAL_WINNER has drop {
        dummy_field: bool,
    }

    struct FinalWinner has store, key {
        id: 0x2::object::UID,
        shares: u64,
        state: u8,
    }

    public fun get_shares(arg0: &FinalWinner) : u64 {
        arg0.shares
    }

    fun init(arg0: FINAL_WINNER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<FINAL_WINNER>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun is_claimable(arg0: &FinalWinner) : bool {
        arg0.state == 1
    }

    public fun is_claimable_with_type<T0>(arg0: &FinalWinner) : bool {
        !0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, u8>(&arg0.id, 0x1::type_name::get<T0>())
    }

    public(friend) fun mint(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : FinalWinner {
        let v0 = FinalWinner{
            id     : 0x2::object::new(arg2),
            shares : arg1,
            state  : 1,
        };
        let v1 = Mint{
            id     : 0x2::object::id<FinalWinner>(&v0),
            winner : arg0,
            shares : arg1,
        };
        0x2::event::emit<Mint>(v1);
        v0
    }

    public(friend) fun set_claimed(arg0: &mut FinalWinner) {
        arg0.state = 0;
        let v0 = Claim{
            id     : 0x2::object::id<FinalWinner>(arg0),
            shares : arg0.shares,
        };
        0x2::event::emit<Claim>(v0);
    }

    public(friend) fun set_claimed_with_type<T0>(arg0: &mut FinalWinner) {
        0x2::dynamic_field::add<0x1::type_name::TypeName, u8>(&mut arg0.id, 0x1::type_name::get<T0>(), 0);
    }

    // decompiled from Move bytecode v6
}

