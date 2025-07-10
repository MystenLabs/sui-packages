module 0x4d64c08f7cc190ab3fbf2a4dbf388f6a44801cdd91e0fbb77ac9647a4c054429::whitelist {
    struct Whitelist has key {
        id: 0x2::object::UID,
        coin_infos: 0x2::vec_map::VecMap<0x1::ascii::String, CoinInfo>,
        protocols: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct CoinInfo has store, key {
        id: 0x2::object::UID,
        decimal: u8,
    }

    struct WhitelistCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_coin<T0>(arg0: &mut Whitelist, arg1: &WhitelistCap, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (0x2::vec_map::contains<0x1::ascii::String, CoinInfo>(&arg0.coin_infos, &v0)) {
            err_coin_already_added();
        };
        let v1 = CoinInfo{
            id      : 0x2::object::new(arg3),
            decimal : arg2,
        };
        0x2::vec_map::insert<0x1::ascii::String, CoinInfo>(&mut arg0.coin_infos, v0, v1);
    }

    public fun add_coin_info_state<T0: copy + drop + store, T1: store>(arg0: &mut CoinInfo, arg1: T0, arg2: T1) {
        if (0x2::dynamic_field::exists_<T0>(&arg0.id, arg1)) {
            err_extra_info_already_existed();
        };
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    public fun add_protocol<T0: drop>(arg0: &mut Whitelist, arg1: &WhitelistCap) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.protocols, &v0)) {
            err_protocol_already_added();
        };
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.protocols, 0x1::type_name::get<T0>());
    }

    public fun add_whitelist_state<T0: copy + drop + store, T1: store>(arg0: &mut Whitelist, arg1: T0, arg2: T1) {
        if (0x2::dynamic_field::exists_<T0>(&arg0.id, arg1)) {
            err_extra_info_already_existed();
        };
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    public fun borrow_coin_info<T0>(arg0: &mut Whitelist) : &CoinInfo {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        0x2::vec_map::get_mut<0x1::ascii::String, CoinInfo>(&mut arg0.coin_infos, &v0)
    }

    public fun borrow_coin_info_mut<T0>(arg0: &mut Whitelist) : &mut CoinInfo {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        0x2::vec_map::get_mut<0x1::ascii::String, CoinInfo>(&mut arg0.coin_infos, &v0)
    }

    public fun decimal(arg0: &Whitelist, arg1: 0x1::ascii::String) : u8 {
        0x2::vec_map::get<0x1::ascii::String, CoinInfo>(&arg0.coin_infos, &arg1).decimal
    }

    fun err_coin_already_added() {
        abort 1000
    }

    fun err_coin_not_added() {
        abort 1001
    }

    fun err_extra_info_already_existed() {
        abort 1002
    }

    fun err_protocol_already_added() {
        abort 1003
    }

    fun err_protocol_not_added() {
        abort 1003
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Whitelist{
            id         : 0x2::object::new(arg0),
            coin_infos : 0x2::vec_map::empty<0x1::ascii::String, CoinInfo>(),
            protocols  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = WhitelistCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Whitelist>(v0);
        0x2::transfer::public_transfer<WhitelistCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_allowed_protocol<T0: drop>(arg0: &Whitelist) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.protocols, &v0)
    }

    public fun is_coin_type_in_whitelist(arg0: &Whitelist, arg1: 0x1::ascii::String) : bool {
        0x2::vec_map::contains<0x1::ascii::String, CoinInfo>(&arg0.coin_infos, &arg1)
    }

    public fun remove_coin<T0>(arg0: &mut Whitelist) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (!0x2::vec_map::contains<0x1::ascii::String, CoinInfo>(&arg0.coin_infos, &v0)) {
            err_coin_not_added();
        };
        let (_, v2) = 0x2::vec_map::remove<0x1::ascii::String, CoinInfo>(&mut arg0.coin_infos, &v0);
        let CoinInfo {
            id      : v3,
            decimal : _,
        } = v2;
        0x2::object::delete(v3);
    }

    public fun remove_protocol<T0: drop>(arg0: &mut Whitelist, arg1: &WhitelistCap) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.protocols, &v0)) {
            err_protocol_not_added();
        };
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.protocols, &v0);
    }

    // decompiled from Move bytecode v6
}

