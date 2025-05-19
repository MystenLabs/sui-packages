module 0x46bc7c1fdc34a887ed6c158ea0487c2b30a562ad6500a10e4d7b49f0589d062b::referral_vip {
    struct ReferralVip has key {
        id: 0x2::object::UID,
        number: u64,
        level: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ReferralOwners has key {
        id: 0x2::object::UID,
        owners: 0x2::table::Table<0x1::string::String, 0x2::table::Table<address, 0x2::object::ID>>,
        number: u64,
    }

    struct MintPass {
        receipient: address,
        level: 0x1::string::String,
    }

    struct Payment<phantom T0> has key {
        id: 0x2::object::UID,
        amount: u64,
        attributes: 0x46bc7c1fdc34a887ed6c158ea0487c2b30a562ad6500a10e4d7b49f0589d062b::attr_factory::Attributes,
    }

    struct AdminMinted has copy, drop {
        receipient: address,
        sender: address,
        level: 0x1::string::String,
    }

    struct PublicMinted has copy, drop {
        receipient: address,
        coinType: 0x1::type_name::TypeName,
        amount: u64,
        sender: address,
        level: 0x1::string::String,
    }

    struct REFERRAL_VIP has drop {
        dummy_field: bool,
    }

    public fun admin_mint_pass<T0>(arg0: &AdminCap, arg1: &Payment<0x2::coin::Coin<T0>>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : MintPass {
        let v0 = 0x46bc7c1fdc34a887ed6c158ea0487c2b30a562ad6500a10e4d7b49f0589d062b::attr_factory::level(&arg1.attributes);
        let v1 = MintPass{
            receipient : arg2,
            level      : v0,
        };
        let v2 = AdminMinted{
            receipient : arg2,
            sender     : 0x2::tx_context::sender(arg3),
            level      : v0,
        };
        0x2::event::emit<AdminMinted>(v2);
        v1
    }

    entry fun create_payment<T0>(arg0: &AdminCap, arg1: &mut ReferralOwners, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Payment<0x2::coin::Coin<T0>>{
            id         : 0x2::object::new(arg4),
            amount     : arg3,
            attributes : 0x46bc7c1fdc34a887ed6c158ea0487c2b30a562ad6500a10e4d7b49f0589d062b::attr_factory::create_attr(arg2),
        };
        if (!0x2::table::contains<0x1::string::String, 0x2::table::Table<address, 0x2::object::ID>>(&arg1.owners, arg2)) {
            0x2::table::add<0x1::string::String, 0x2::table::Table<address, 0x2::object::ID>>(&mut arg1.owners, arg2, 0x2::table::new<address, 0x2::object::ID>(arg4));
        };
        0x2::transfer::share_object<Payment<0x2::coin::Coin<T0>>>(v0);
    }

    entry fun destroy_payment<T0>(arg0: &AdminCap, arg1: Payment<0x2::coin::Coin<T0>>) {
        let Payment {
            id         : v0,
            amount     : _,
            attributes : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    fun init(arg0: REFERRAL_VIP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"QuantHiveAI Referral VIP #{number}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.quanthive.ai"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.quanthive.ai/nft_{level}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"4578636c757369766520416d6261737361646f72202620416666696c69617465206d656d6265727368697020746f205175616e7448697665414920e28094206120646563656e7472616c697a65642074726164696e6720706c6174666f726d20737570706f7274696e6720626f7468206f6d6e692d636861696e20737761707320616e642070657270657475616c732e205175616e7448697665206c65766572616765732041492d64726976656e20736f6369616c206c697374656e696e6720616e64206f6e2d636861696e206461746120746f20747261636b20746865206167677265676174656420666c6f7773206f6620746865206d6f73742070726f66697461626c6520616c70686120747261646572732c207475726e696e6720746865697220616374697669747920696e746f207265616c2d74696d652c20616374696f6e61626c652074726164696e67207369676e616c732e"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"QuantHiveAI"));
        let v4 = 0x2::package::claim<REFERRAL_VIP>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<ReferralVip>(&v4, v0, v2, arg1);
        0x2::display::update_version<ReferralVip>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<ReferralVip>(&v4, arg1);
        let v8 = ReferralOwners{
            id     : 0x2::object::new(arg1),
            owners : 0x2::table::new<0x1::string::String, 0x2::table::Table<address, 0x2::object::ID>>(arg1),
            number : 0,
        };
        let v9 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<ReferralVip>>(v6);
        0x2::transfer::share_object<ReferralOwners>(v8);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<ReferralVip>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ReferralVip>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v9, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: MintPass, arg1: &mut ReferralOwners, arg2: &mut 0x2::tx_context::TxContext) {
        let MintPass {
            receipient : v0,
            level      : v1,
        } = arg0;
        let v2 = 0x2::table::borrow_mut<0x1::string::String, 0x2::table::Table<address, 0x2::object::ID>>(&mut arg1.owners, v1);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(v2, v0), 0);
        arg1.number = arg1.number + 1;
        let v3 = ReferralVip{
            id     : 0x2::object::new(arg2),
            number : arg1.number,
            level  : v1,
        };
        0x2::table::add<address, 0x2::object::ID>(v2, v0, 0x2::object::id<ReferralVip>(&v3));
        0x2::transfer::transfer<ReferralVip>(v3, v0);
    }

    public fun public_mint_pass<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &Payment<0x2::coin::Coin<T0>>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : MintPass {
        assert!(0x2::coin::value<T0>(&arg0) == arg1.amount, 1);
        let v0 = 0x46bc7c1fdc34a887ed6c158ea0487c2b30a562ad6500a10e4d7b49f0589d062b::attr_factory::level(&arg1.attributes);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x1eb3f20017703b8fbd6b7398106da758995489c0f11263ff98173edd2f2eca5e);
        let v1 = MintPass{
            receipient : arg2,
            level      : v0,
        };
        let v2 = PublicMinted{
            receipient : arg2,
            coinType   : 0x1::type_name::get<T0>(),
            amount     : arg1.amount,
            sender     : 0x2::tx_context::sender(arg3),
            level      : v0,
        };
        0x2::event::emit<PublicMinted>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

