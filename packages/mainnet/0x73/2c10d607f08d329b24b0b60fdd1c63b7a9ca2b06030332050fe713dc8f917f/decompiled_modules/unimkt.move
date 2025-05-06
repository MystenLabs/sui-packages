module 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::unimkt {
    struct AreaCfg has store {
        province_ratio: u64,
        city_ratio: u64,
        zone_ratio: u64,
    }

    struct CommunityCfg has store {
        branch_ratio: u64,
        division_ratio: u64,
        associate_ratio: u64,
    }

    struct SupplyCfg has store {
        shift_ratio: u64,
        locked_ratio: u64,
        nxt_unlock_ratio: u64,
    }

    struct Unimkt has store {
        lotto: 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::lotto::Lotto,
        area: AreaCfg,
        community: CommunityCfg,
        supply: SupplyCfg,
    }

    struct Province has store {
        area: 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::area::Account,
    }

    struct City has store {
        area: 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::area::Account,
    }

    struct Zone has store {
        area: 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::area::Account,
    }

    struct Branch has store {
        community: 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::community::Account,
    }

    struct Division has store {
        community: 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::community::Account,
    }

    struct Associate has store {
        community: 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::community::Account,
    }

    struct Merchant has store {
        merchant: 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::merchant::Account,
        lotto: 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::lotto::Account,
    }

    struct Member has store {
        member: 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::member::Account,
        lotto: 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::lotto::Account,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AreaCfg{
            province_ratio : 100,
            city_ratio     : 200,
            zone_ratio     : 200,
        };
        let v1 = CommunityCfg{
            branch_ratio    : 500,
            division_ratio  : 100,
            associate_ratio : 800,
        };
        let v2 = SupplyCfg{
            shift_ratio      : 10000,
            locked_ratio     : 8000,
            nxt_unlock_ratio : 2000,
        };
        let v3 = Unimkt{
            lotto     : 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::lotto::new_lotto(4000, arg0),
            area      : v0,
            community : v1,
            supply    : v2,
        };
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::business::create_business<Unimkt>(@0x3f2620474648cb8f054e65dac2723c3253922a9181db7d3edd7cf4fa830c3a73, b"UNIMKT", 0x2::tx_context::sender(arg0), 0x2::tx_context::sender(arg0), 0, v3, arg0);
    }

    public entry fun public_associate_set_division(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Associate>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::set_superior<Associate>(arg0, arg1);
    }

    public entry fun public_associate_withdraw(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Associate>, arg1: &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::token::Token<0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::digi::DIGI>, arg2: &mut 0x2::coin::TreasuryCap<0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::digi::DIGI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::community::withdraw(arg1, arg2, &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::node_borrow_mut<Associate>(arg0).community, 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::benefit_borrow<Associate>(arg0), arg3);
    }

    public entry fun public_branch_withdraw(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Branch>, arg1: &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::token::Token<0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::digi::DIGI>, arg2: &mut 0x2::coin::TreasuryCap<0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::digi::DIGI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::community::withdraw(arg1, arg2, &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::node_borrow_mut<Branch>(arg0).community, 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::benefit_borrow<Branch>(arg0), arg3);
    }

    public entry fun public_city_set_province(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<City>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::set_superior<City>(arg0, arg1);
    }

    public entry fun public_city_withdraw(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<City>, arg1: &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::token::Token<0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::digi::DIGI>, arg2: &mut 0x2::coin::TreasuryCap<0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::digi::DIGI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::area::withdraw(arg1, arg2, &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::node_borrow_mut<City>(arg0).area, 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::benefit_borrow<City>(arg0), arg3);
    }

    public entry fun public_create_associate(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Division>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Associate{community: 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::community::new_account()};
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::add_node<Associate, Division>(arg0, arg1, 23, v0, arg2);
    }

    public entry fun public_create_branch(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::network::Network, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Branch{community: 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::community::new_account()};
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::create_node<Branch>(arg0, arg1, 21, v0, arg2);
    }

    public entry fun public_create_city(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Province>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = City{area: 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::area::new_account()};
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::add_node<City, Province>(arg0, arg1, 12, v0, arg2);
    }

    public entry fun public_create_division(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Branch>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Division{community: 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::community::new_account()};
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::add_node<Division, Branch>(arg0, arg1, 22, v0, arg2);
    }

    public entry fun public_create_member(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Merchant>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Member{
            member : 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::member::new_account(),
            lotto  : 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::lotto::new_account(1000, 10, 0x2::clock::timestamp_ms(arg2)),
        };
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::add_node<Member, Merchant>(arg0, arg1, 9, v0, arg3);
    }

    public entry fun public_create_merchant(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Associate>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2;
        let v1 = 10;
        if (arg2 == 0) {
            v0 = 300;
            v1 = 300;
        };
        let v2 = Merchant{
            merchant : 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::merchant::new_account(),
            lotto    : 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::lotto::new_account(v0, v1, 0x2::clock::timestamp_ms(arg3)),
        };
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::add_node<Merchant, Associate>(arg0, arg1, 8, v2, arg4);
    }

    public entry fun public_create_province(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::network::Network, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Province{area: 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::area::new_account()};
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::create_node<Province>(arg0, arg1, 11, v0, arg2);
    }

    public entry fun public_create_zone(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<City>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Zone{area: 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::area::new_account()};
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::add_node<Zone, City>(arg0, arg1, 13, v0, arg2);
    }

    public entry fun public_division_set_branch(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Division>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::set_superior<Division>(arg0, arg1);
    }

    public entry fun public_division_withdraw(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Division>, arg1: &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::token::Token<0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::digi::DIGI>, arg2: &mut 0x2::coin::TreasuryCap<0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::digi::DIGI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::community::withdraw(arg1, arg2, &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::node_borrow_mut<Division>(arg0).community, 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::benefit_borrow<Division>(arg0), arg3);
    }

    public entry fun public_lotto_area_set(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::business::Business<Unimkt>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_check(arg1);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_check(arg2);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_check(arg3);
        let v0 = &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::business::business_borrow_mut<Unimkt>(arg0).area;
        v0.province_ratio = arg1;
        v0.city_ratio = arg2;
        v0.zone_ratio = arg3;
    }

    public entry fun public_lotto_community_set(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::business::Business<Unimkt>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_check(arg1);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_check(arg2);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_check(arg3);
        let v0 = &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::business::business_borrow_mut<Unimkt>(arg0).community;
        v0.branch_ratio = arg1;
        v0.division_ratio = arg2;
        v0.associate_ratio = arg3;
    }

    public entry fun public_lotto_member_claim(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::business::Business<Unimkt>, arg1: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Member>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::node_borrow_mut<Member>(arg1);
        0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::lotto::claim(&mut v0.lotto, &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::business::business_borrow_mut<Unimkt>(arg0).lotto, 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::member::borrow_kaka_mut(&mut v0.member));
    }

    public entry fun public_lotto_merchant_claim(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::business::Business<Unimkt>, arg1: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Merchant>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::node_borrow_mut<Merchant>(arg1);
        0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::lotto::claim(&mut v0.lotto, &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::business::business_borrow_mut<Unimkt>(arg0).lotto, 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::merchant::borrow_dada_mut(&mut v0.merchant));
    }

    public entry fun public_lotto_supply_set(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::business::Business<Unimkt>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_check(arg1);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_check(arg2);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_check(arg3);
        let v0 = &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::business::business_borrow_mut<Unimkt>(arg0).supply;
        v0.shift_ratio = arg1;
        v0.locked_ratio = arg2;
        v0.nxt_unlock_ratio = arg3;
    }

    public entry fun public_lotto_trigger(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::network::Network, arg1: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::business::Business<Unimkt>, arg2: u64, arg3: u64, arg4: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Member>, arg5: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Merchant>, arg6: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Merchant>, arg7: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Associate>, arg8: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Division>, arg9: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Branch>, arg10: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Zone>, arg11: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<City>, arg12: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Province>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > arg3, 400001);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::network::fee(arg0, 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(arg2, 18));
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::check_superior<Merchant>(arg5, 0x2::object::id_address<0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Associate>>(arg7));
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::check_superior<Associate>(arg7, 0x2::object::id_address<0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Division>>(arg8));
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::check_superior<Division>(arg8, 0x2::object::id_address<0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Branch>>(arg9));
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::check_superior<Zone>(arg10, 0x2::object::id_address<0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<City>>(arg11));
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::check_superior<City>(arg11, 0x2::object::id_address<0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Province>>(arg12));
        let v0 = 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::business::business_borrow<Unimkt>(arg1);
        0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::area::reward(&mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::node_borrow_mut<Province>(arg12).area, 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(arg3, v0.area.province_ratio));
        0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::area::reward(&mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::node_borrow_mut<City>(arg11).area, 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(arg3, v0.area.city_ratio));
        0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::area::reward(&mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::node_borrow_mut<Zone>(arg10).area, 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(arg3, v0.area.zone_ratio));
        0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::community::reward(&mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::node_borrow_mut<Branch>(arg9).community, 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(arg3, v0.community.branch_ratio));
        0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::community::reward(&mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::node_borrow_mut<Division>(arg8).community, 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(arg3, v0.community.division_ratio));
        0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::community::reward(&mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::node_borrow_mut<Associate>(arg7).community, 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(arg3, v0.community.associate_ratio));
        let v1 = 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::node_borrow_mut<Merchant>(arg5);
        let v2 = 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::merchant::borrow_dada_mut(&mut v1.merchant);
        let v3 = 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(arg3, v0.supply.shift_ratio);
        let v4 = 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(v3, v0.supply.locked_ratio);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::unlock(v2, 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(v3, v0.supply.nxt_unlock_ratio));
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::increase_available(v2, v3 - v4);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::increase_locked(v2, v4);
        0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::lotto::trigger(&mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::business::business_borrow_mut<Unimkt>(arg1).lotto, &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::node_borrow_mut<Member>(arg4).lotto, &mut v1.lotto, &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::node_borrow_mut<Merchant>(arg6).lotto, arg2, arg3, arg13, arg14);
    }

    public entry fun public_member_set_merchant(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Member>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::set_superior<Member>(arg0, arg1);
    }

    public entry fun public_member_withdraw(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Member>, arg1: &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::token::Token<0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::kaka::KAKA>, arg2: &mut 0x2::coin::TreasuryCap<0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::kaka::KAKA>, arg3: &mut 0x2::tx_context::TxContext) {
        0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::member::withdraw(arg1, arg2, &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::node_borrow_mut<Member>(arg0).member, 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::benefit_borrow<Member>(arg0), arg3);
    }

    public entry fun public_merchant_set_associate(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Merchant>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::set_superior<Merchant>(arg0, arg1);
    }

    public entry fun public_merchant_set_invest(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Merchant>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_check(arg1);
        0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::lotto::set_acc_ratio(&mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::node_borrow_mut<Merchant>(arg0).lotto, arg1, arg1);
    }

    public entry fun public_merchant_withdraw(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Merchant>, arg1: &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::token::Token<0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::dada::DADA>, arg2: &mut 0x2::coin::TreasuryCap<0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::dada::DADA>, arg3: &mut 0x2::tx_context::TxContext) {
        0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::merchant::withdraw(arg1, arg2, &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::node_borrow_mut<Merchant>(arg0).merchant, 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::benefit_borrow<Merchant>(arg0), arg3);
    }

    public entry fun public_province_withdraw(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Province>, arg1: &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::token::Token<0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::digi::DIGI>, arg2: &mut 0x2::coin::TreasuryCap<0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::digi::DIGI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::area::withdraw(arg1, arg2, &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::node_borrow_mut<Province>(arg0).area, 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::benefit_borrow<Province>(arg0), arg3);
    }

    public entry fun public_zone_set_city(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Zone>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::set_superior<Zone>(arg0, arg1);
    }

    public entry fun public_zone_withdraw(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::Node<Zone>, arg1: &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::token::Token<0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::digi::DIGI>, arg2: &mut 0x2::coin::TreasuryCap<0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::digi::DIGI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::area::withdraw(arg1, arg2, &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::node_borrow_mut<Zone>(arg0).area, 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node::benefit_borrow<Zone>(arg0), arg3);
    }

    // decompiled from Move bytecode v6
}

