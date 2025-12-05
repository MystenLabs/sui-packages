module 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow {
    struct VOTING_ESCROW has drop {
        dummy_field: bool,
    }

    struct VotingEscrow has store, key {
        id: 0x2::object::UID,
        index: u64,
        name: 0x1::string::String,
        url: 0x2::url::Url,
        locked_amount: u64,
        locked_amount_text: 0x1::string::String,
        expire_at: u64,
        expire_at_text: 0x1::string::String,
        voted: bool,
        point_history: 0x2::table_vec::TableVec<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::point::Point>,
    }

    public fun id(arg0: &VotingEscrow) : 0x2::object::ID {
        0x2::object::id<VotingEscrow>(arg0)
    }

    public fun url(arg0: &VotingEscrow) : 0x2::url::Url {
        arg0.url
    }

    public fun point(arg0: &VotingEscrow, arg1: u64) : 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::point::Point {
        *0x2::table_vec::borrow<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::point::Point>(&arg0.point_history, arg1 - 1)
    }

    public(friend) fun abstain(arg0: &mut VotingEscrow) {
        arg0.voted = false;
    }

    public fun balance_of_nft(arg0: &VotingEscrow, arg1: &0x2::clock::Clock) : u64 {
        balance_of_nft_(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    fun balance_of_nft_(arg0: &VotingEscrow, arg1: u64) : u64 {
        let v0 = point_epoch(arg0);
        if (v0 == 0) {
            return 0
        };
        let v1 = point(arg0, v0);
        let v2 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::sub(0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::point::bias(&v1), 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::div_u64(0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::mul(0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::point::slope(&v1), 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::sub_u64(0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::from_u64(arg1), 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::point::ts(&v1))), 1000000000));
        if (0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::is_negative(&v2)) {
            v2 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::zero();
        };
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::int128::to_u64(v2)
    }

    public fun balance_of_nft_at(arg0: &VotingEscrow, arg1: u64) : u64 {
        balance_of_nft_(arg0, arg1)
    }

    public(friend) fun burn(arg0: VotingEscrow) {
        let VotingEscrow {
            id                 : v0,
            index              : _,
            name               : _,
            url                : _,
            locked_amount      : _,
            locked_amount_text : _,
            expire_at          : _,
            expire_at_text     : _,
            voted              : _,
            point_history      : v9,
        } = arg0;
        0x2::table_vec::drop<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::point::Point>(v9);
        0x2::object::delete(v0);
    }

    public(friend) fun deposit(arg0: &mut VotingEscrow, arg1: u64, arg2: u64) {
        deposit_(arg0, arg1, arg2);
    }

    fun deposit_(arg0: &mut VotingEscrow, arg1: u64, arg2: u64) {
        arg0.locked_amount = arg0.locked_amount + arg1;
        arg0.locked_amount_text = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::utils::format_amount_1dp(arg0.locked_amount, 9);
        if (arg2 > 0) {
            arg0.expire_at = arg2;
            arg0.expire_at_text = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::utils::format_dd_mm_yyyy_utc(arg0.expire_at);
        };
    }

    public fun index(arg0: &VotingEscrow) : u64 {
        arg0.index
    }

    fun init(arg0: VOTING_ESCROW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"TydeShift Lock #{index}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"4c6f636b6564207b6c6f636b65645f616d6f756e745f746578747d205459444520e280a22045787069726573206174207b6578706972655f61745f746578747d"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://tydeshift.com"));
        let v4 = 0x2::package::claim<VOTING_ESCROW>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<VotingEscrow>(&v4, v0, v2, arg1);
        0x2::display::update_version<VotingEscrow>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<VotingEscrow>>(v5, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun insert_point(arg0: &mut VotingEscrow, arg1: 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::point::Point) {
        insert_point_(arg0, arg1);
    }

    fun insert_point_(arg0: &mut VotingEscrow, arg1: 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::point::Point) {
        0x2::table_vec::push_back<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::point::Point>(&mut arg0.point_history, arg1);
    }

    public fun locked(arg0: &VotingEscrow) : (u64, u64) {
        (arg0.locked_amount, arg0.expire_at)
    }

    public(friend) fun mint(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : VotingEscrow {
        mint_(arg0, arg1)
    }

    fun mint_(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : VotingEscrow {
        let v0 = 0x1::string::utf8(b"TydeShift Lock #");
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg0));
        VotingEscrow{
            id                 : 0x2::object::new(arg1),
            index              : arg0,
            name               : v0,
            url                : 0x2::url::new_unsafe_from_bytes(b"https://qgzkoqpd526oukt4sys3sxcmpywr7xthdqu4xhwotv7ooj47gfgq.arweave.net/gbKnQePuvOoqfJYluVxMfi0f3mccKcuezp1-5yefMU0"),
            locked_amount      : 0,
            locked_amount_text : 0x1::string::utf8(b""),
            expire_at          : 0,
            expire_at_text     : 0x1::string::utf8(b""),
            voted              : false,
            point_history      : 0x2::table_vec::empty<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::point::Point>(arg1),
        }
    }

    public fun name(arg0: &VotingEscrow) : 0x1::string::String {
        arg0.name
    }

    public fun point_epoch(arg0: &VotingEscrow) : u64 {
        0x2::table_vec::length<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::point::Point>(&arg0.point_history)
    }

    public fun voted(arg0: &VotingEscrow) : bool {
        arg0.voted
    }

    public(friend) fun voting(arg0: &mut VotingEscrow) {
        arg0.voted = true;
    }

    // decompiled from Move bytecode v6
}

