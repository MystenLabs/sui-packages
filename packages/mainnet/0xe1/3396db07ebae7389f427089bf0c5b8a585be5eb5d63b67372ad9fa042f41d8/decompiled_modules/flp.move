module 0xe13396db07ebae7389f427089bf0c5b8a585be5eb5d63b67372ad9fa042f41d8::flp {
    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    struct Flp1<phantom T0> has store, key {
        id: 0x2::object::UID,
        number: u64,
        lots: u64,
        claimed_rounds: 0x2::vec_map::VecMap<u16, u64>,
        total_claimed: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct Minted<phantom T0> has copy, drop {
        nft_id: 0x2::object::ID,
        number: u64,
        lots: u64,
    }

    struct Claimed<phantom T0> has copy, drop {
        nft_id: 0x2::object::ID,
        round: u16,
        amount: u64,
        lots: u64,
        claimer: address,
    }

    public fun attributes<T0>(arg0: &Flp1<T0>) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun burn_mint_cap(arg0: MintCap) {
        let MintCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun claim<T0>(arg0: &mut Flp1<T0>, arg1: &mut 0xe13396db07ebae7389f427089bf0c5b8a585be5eb5d63b67372ad9fa042f41d8::pool::Pool<T0>, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!0x2::vec_map::contains<u16, u64>(&arg0.claimed_rounds, &arg2), 0xe13396db07ebae7389f427089bf0c5b8a585be5eb5d63b67372ad9fa042f41d8::errors::already_claimed());
        let v0 = 0xe13396db07ebae7389f427089bf0c5b8a585be5eb5d63b67372ad9fa042f41d8::pool::claim_rewards<T0>(arg1, (arg2 as u64), arg0.lots);
        let v1 = 0x2::balance::value<T0>(&v0);
        arg0.total_claimed = arg0.total_claimed + v1;
        0x2::vec_map::insert<u16, u64>(&mut arg0.claimed_rounds, arg2, v1);
        let v2 = Claimed<T0>{
            nft_id  : 0x2::object::id<Flp1<T0>>(arg0),
            round   : arg2,
            amount  : v1,
            lots    : arg0.lots,
            claimer : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Claimed<T0>>(v2);
        0x2::coin::from_balance<T0>(v0, arg3)
    }

    public fun claimed_rounds<T0>(arg0: &Flp1<T0>) : &0x2::vec_map::VecMap<u16, u64> {
        &arg0.claimed_rounds
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<MintCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun lots<T0>(arg0: &Flp1<T0>) : u64 {
        arg0.lots
    }

    public(friend) fun mint<T0>(arg0: &MintCap, arg1: &mut 0xe13396db07ebae7389f427089bf0c5b8a585be5eb5d63b67372ad9fa042f41d8::pool::Pool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Flp1<T0> {
        assert!(arg2 != 0, 0xe13396db07ebae7389f427089bf0c5b8a585be5eb5d63b67372ad9fa042f41d8::errors::invalid_params());
        let v0 = 0x2::object::new(arg3);
        let v1 = 0xe13396db07ebae7389f427089bf0c5b8a585be5eb5d63b67372ad9fa042f41d8::pool::record_mint<T0>(arg1, arg2, 0x2::object::uid_to_inner(&v0));
        let v2 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"Lots"), 0x1::u64::to_string(arg2));
        let v3 = Flp1<T0>{
            id             : v0,
            number         : v1,
            lots           : arg2,
            claimed_rounds : 0x2::vec_map::empty<u16, u64>(),
            total_claimed  : 0,
            attributes     : v2,
        };
        let v4 = Minted<T0>{
            nft_id : 0x2::object::id<Flp1<T0>>(&v3),
            number : v1,
            lots   : arg2,
        };
        0x2::event::emit<Minted<T0>>(v4);
        v3
    }

    public(friend) fun new_display<T0>(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<Flp1<T0>> {
        let v0 = 0x2::display::new<Flp1<T0>>(arg0, arg4);
        0x2::display::add<Flp1<T0>>(&mut v0, 0x1::string::utf8(b"name"), arg1);
        0x2::display::add<Flp1<T0>>(&mut v0, 0x1::string::utf8(b"description"), arg2);
        0x2::display::add<Flp1<T0>>(&mut v0, 0x1::string::utf8(b"image_url"), arg3);
        0x2::display::add<Flp1<T0>>(&mut v0, 0x1::string::utf8(b"lots"), 0x1::string::utf8(b"{lots}"));
        0x2::display::add<Flp1<T0>>(&mut v0, 0x1::string::utf8(b"total_claimed"), 0x1::string::utf8(b"{total_claimed}"));
        0x2::display::add<Flp1<T0>>(&mut v0, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<Flp1<T0>>(&mut v0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://www.current.finance/"));
        0x2::display::add<Flp1<T0>>(&mut v0, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Current Finance"));
        0x2::display::update_version<Flp1<T0>>(&mut v0);
        v0
    }

    public(friend) fun new_policy<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferPolicy<Flp1<T0>>, 0x2::transfer_policy::TransferPolicyCap<Flp1<T0>>) {
        let (v0, v1) = 0x2::transfer_policy::new<Flp1<T0>>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Flp1<T0>>(&mut v3, &v2);
        (v3, v2)
    }

    public fun number<T0>(arg0: &Flp1<T0>) : u64 {
        arg0.number
    }

    public fun total_claimed<T0>(arg0: &Flp1<T0>) : u64 {
        arg0.total_claimed
    }

    // decompiled from Move bytecode v6
}

