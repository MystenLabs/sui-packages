module 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token {
    struct VE_TOKEN has drop {
        dummy_field: bool,
    }

    struct VeToken has store, key {
        id: 0x2::object::UID,
        bond_mode: u8,
        unbond_at: u64,
        staked: bool,
        balance: 0x2::balance::Balance<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>,
    }

    public fun balance(arg0: &VeToken) : u64 {
        0x2::balance::value<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&arg0.balance)
    }

    public(friend) fun split(arg0: &mut VeToken, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : VeToken {
        assert!(arg1 > 0 && arg1 < 0x2::balance::value<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&arg0.balance), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_invalid_split_amount());
        VeToken{
            id        : 0x2::object::new(arg2),
            bond_mode : arg0.bond_mode,
            unbond_at : arg0.unbond_at,
            staked    : arg0.staked,
            balance   : 0x2::balance::split<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&mut arg0.balance, arg1),
        }
    }

    public fun bond_info(arg0: &VeToken) : (u64, u8, u64, bool) {
        (0x2::balance::value<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&arg0.balance), arg0.bond_mode, arg0.unbond_at, arg0.staked)
    }

    public fun bond_mode(arg0: &VeToken) : u8 {
        arg0.bond_mode
    }

    fun check_merge_allowed(arg0: &VeToken, arg1: &VeToken) : bool {
        arg0.staked != arg1.staked && false || arg0.bond_mode == 2 || arg1.bond_mode == 2 && false || arg0.unbond_at >= arg1.unbond_at
    }

    public(friend) fun create(arg0: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::VeMMT, arg1: 0x2::balance::Balance<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>, arg2: u64, arg3: u8, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : VeToken {
        assert!(arg3 == 1 || arg3 == 2, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_invalid_bond_mode());
        assert!(arg2 >= 0x2::clock::timestamp_ms(arg5) && arg2 < 18446744073709551615, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_invalid_unbond_at());
        if (arg3 == 2) {
            let (v0, v1) = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::config_fields(arg0);
            assert!(arg2 == 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::convert_to_epoch_start(v1, 0x2::clock::timestamp_ms(arg5)) + 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::vote_power::max_bond_epochs(v0) * 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::epoch_interval_ms(v1), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_invalid_unbond_at());
        };
        VeToken{
            id        : 0x2::object::new(arg6),
            bond_mode : arg3,
            unbond_at : arg2,
            staked    : arg4,
            balance   : arg1,
        }
    }

    public(friend) fun deposit(arg0: &mut VeToken, arg1: 0x2::balance::Balance<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>) {
        0x2::balance::join<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&mut arg0.balance, arg1);
    }

    public(friend) fun extend(arg0: &mut VeToken, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = if (arg1 > arg0.unbond_at) {
            if (arg1 > 0x2::clock::timestamp_ms(arg2)) {
                arg1 < 18446744073709551615
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_invalid_unbond_at());
        arg0.unbond_at = arg1;
    }

    public fun get_dynamic_field<T0: drop + store>(arg0: &VeToken) : &T0 {
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, T0>(&arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    public(friend) fun get_dynamic_field_mut<T0: drop + store>(arg0: &mut VeToken) : &mut T0 {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, T0>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    public(friend) fun has_dynamic_field<T0: drop + store>(arg0: &VeToken) : bool {
        0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, T0>(&arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun id(arg0: &VeToken) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    fun init(arg0: VE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Depositing Escrow NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b""));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b""));
        let v4 = 0x2::package::claim<VE_TOKEN>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<VeToken>(&v4, v0, v2, arg1);
        0x2::display::update_version<VeToken>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<VeToken>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun is_staked(arg0: &VeToken) : bool {
        arg0.staked
    }

    public(friend) fun merge(arg0: &mut VeToken, arg1: VeToken) {
        assert!(check_merge_allowed(arg0, &arg1), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_invalid_merge());
        let VeToken {
            id        : v0,
            bond_mode : _,
            unbond_at : _,
            staked    : _,
            balance   : v4,
        } = arg1;
        0x2::object::delete(v0);
        0x2::balance::join<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&mut arg0.balance, v4);
    }

    public fun unbond_at(arg0: &VeToken) : u64 {
        arg0.unbond_at
    }

    public(friend) fun update_dynamic_field<T0: drop + store>(arg0: &mut VeToken, arg1: T0) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, T0>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<0x1::type_name::TypeName, T0>(&mut arg0.id, v0);
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, T0>(&mut arg0.id, v0, arg1);
    }

    public(friend) fun withdraw(arg0: VeToken, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT> {
        assert!(0x2::clock::timestamp_ms(arg1) >= unbond_at(&arg0), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_not_unbond_yet());
        let VeToken {
            id        : v0,
            bond_mode : _,
            unbond_at : _,
            staked    : _,
            balance   : v4,
        } = arg0;
        0x2::object::delete(v0);
        v4
    }

    // decompiled from Move bytecode v6
}

