module 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::mint_supply {
    struct MintSupply<phantom T0> has store {
        frozen: bool,
        mint_cap: 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::mint_cap::MintCap<T0>,
        supply: 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::Supply,
    }

    public fun add_domain<T0>(arg0: &mut 0x2::object::UID, arg1: MintSupply<T0>) {
        assert_unregulated<T0>(arg0);
        0x2::dynamic_field::add<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<MintSupply<T0>>, MintSupply<T0>>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<MintSupply<T0>>(), arg1);
    }

    public fun assert_frozen<T0>(arg0: &MintSupply<T0>) {
        assert!(is_frozen<T0>(arg0), 4);
    }

    public fun assert_not_frozen<T0>(arg0: &MintSupply<T0>) {
        assert!(!is_frozen<T0>(arg0), 3);
    }

    public fun assert_regulated<T0>(arg0: &0x2::object::UID) {
        assert!(has_domain<T0>(arg0), 1);
    }

    public fun assert_unregulated<T0>(arg0: &0x2::object::UID) {
        assert!(!has_domain<T0>(arg0), 2);
    }

    public fun borrow_domain<T0>(arg0: &0x2::object::UID) : &MintSupply<T0> {
        assert_regulated<T0>(arg0);
        0x2::dynamic_field::borrow<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<MintSupply<T0>>, MintSupply<T0>>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<MintSupply<T0>>())
    }

    public fun borrow_domain_mut<T0>(arg0: &mut 0x2::object::UID) : &mut MintSupply<T0> {
        assert_regulated<T0>(arg0);
        0x2::dynamic_field::borrow_mut<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<MintSupply<T0>>, MintSupply<T0>>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<MintSupply<T0>>())
    }

    public fun decrease_max_supply<T0>(arg0: &mut MintSupply<T0>, arg1: u64) {
        assert_not_frozen<T0>(arg0);
        0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::decrease_maximum(&mut arg0.supply, arg1);
    }

    public fun delegate<T0>(arg0: &mut MintSupply<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::mint_cap::MintCap<T0> {
        0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::increment(&mut arg0.supply, arg1);
        0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::mint_cap::split<T0>(&mut arg0.mint_cap, arg1, arg2)
    }

    public fun delegate_and_transfer<T0>(arg0: &mut MintSupply<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = delegate<T0>(arg0, arg1, arg3);
        0x2::transfer::public_transfer<0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::mint_cap::MintCap<T0>>(v0, arg2);
        0x2::object::id<0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::mint_cap::MintCap<T0>>(&v0)
    }

    public fun delete<T0>(arg0: MintSupply<T0>) : 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::mint_cap::MintCap<T0> {
        assert_not_frozen<T0>(&arg0);
        let MintSupply {
            frozen   : _,
            mint_cap : v1,
            supply   : _,
        } = arg0;
        v1
    }

    public fun freeze_supply<T0>(arg0: &mut MintSupply<T0>) {
        arg0.frozen = true;
    }

    public fun get_supply<T0>(arg0: &MintSupply<T0>) : &0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::Supply {
        &arg0.supply
    }

    public fun has_domain<T0>(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<MintSupply<T0>>, MintSupply<T0>>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<MintSupply<T0>>())
    }

    public fun increase_max_supply<T0>(arg0: &mut MintSupply<T0>, arg1: u64) {
        assert_not_frozen<T0>(arg0);
        0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::increase_maximum(&mut arg0.supply, arg1);
    }

    public fun is_frozen<T0>(arg0: &MintSupply<T0>) : bool {
        arg0.frozen
    }

    public fun merge_delegated<T0>(arg0: &mut MintSupply<T0>, arg1: 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::mint_cap::MintCap<T0>) {
        0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::decrement(&mut arg0.supply, 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::mint_cap::supply<T0>(&arg1));
        0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::mint_cap::merge<T0>(&mut arg0.mint_cap, arg1);
    }

    public fun new<T0>(arg0: 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::mint_cap::MintCap<T0>, arg1: u64, arg2: bool) : MintSupply<T0> {
        MintSupply<T0>{
            frozen   : arg2,
            mint_cap : arg0,
            supply   : 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils_supply::new(arg1),
        }
    }

    public fun remove_domain<T0>(arg0: &mut 0x2::object::UID) : MintSupply<T0> {
        assert_regulated<T0>(arg0);
        0x2::dynamic_field::remove<0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::Marker<MintSupply<T0>>, MintSupply<T0>>(arg0, 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::marker<MintSupply<T0>>())
    }

    // decompiled from Move bytecode v6
}

