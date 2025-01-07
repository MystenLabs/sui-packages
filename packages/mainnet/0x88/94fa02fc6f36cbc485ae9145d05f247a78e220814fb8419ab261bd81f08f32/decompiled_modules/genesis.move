module 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::genesis {
    struct Mint has store, key {
        id: 0x2::object::UID,
        minting_price: u64,
        inner_hash: vector<u8>,
        mixing_limit: u8,
        profits: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun add_country_code<T0>(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut Mint, arg2: 0x1::string::String) {
        0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::add_country_code<T0>(arg0, &mut arg1.id, arg2);
    }

    public fun add_genes<T0>(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut Mint, arg2: vector<u8>) {
        0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::genes::add_gene_definitions<T0>(&mut arg1.id, arg2);
    }

    public fun authorize<T0>(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut Mint, arg2: u32, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: vector<0x1::string::String>) {
        0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::authorize_app<T0>(arg0, &mut arg1.id, 0x1::string::utf8(b"genesis"), arg2, arg3, arg4, arg5, arg6);
    }

    public fun deauthorize<T0>(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut Mint) {
        0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::revoke_auth<T0>(arg0, &mut arg1.id);
    }

    public fun get_minting_price(arg0: &Mint) : u64 {
        arg0.minting_price
    }

    fun handle_payment(arg0: &mut Mint, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.minting_price;
        assert!(v0 <= 0x2::coin::value<0x2::sui::SUI>(arg1), 0);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.profits, 0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_bytes(&v0);
        let v2 = Mint{
            id            : v0,
            minting_price : 8000000000,
            inner_hash    : 0x2::hash::blake2b256(&v1),
            mixing_limit  : 5,
            profits       : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Mint>(v2);
    }

    public fun mint<T0>(arg0: &mut Mint, arg1: &0x2::clock::Clock, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0> {
        assert!(0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::is_authorized<T0>(&arg0.id), 2);
        handle_payment(arg0, arg2, arg3);
        let v0 = 0x2::tx_context::fresh_object_address(arg3);
        let v1 = 0x1::vector::empty<vector<u8>>();
        let v2 = &mut v1;
        0x1::vector::push_back<vector<u8>>(v2, arg0.inner_hash);
        0x1::vector::push_back<vector<u8>>(v2, 0x2::bcs::to_bytes<address>(&v0));
        0x1::vector::push_back<vector<u8>>(v2, 0x2::bcs::to_bytes<0x2::clock::Clock>(arg1));
        let v3 = 0x2::bcs::to_bytes<vector<vector<u8>>>(&v1);
        let v4 = 0x2::hash::blake2b256(&v3);
        arg0.inner_hash = v4;
        0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::mint<T0>(&mut arg0.id, 0, v4, 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::genes::get_attributes<T0>(&arg0.id, &v4), arg1, arg3)
    }

    public fun remove_country_code<T0>(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut Mint, arg2: 0x1::string::String) {
        0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::remove_country_code<T0>(arg0, &mut arg1.id, arg2);
    }

    public fun set_minting_price(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut Mint, arg2: u64) {
        arg1.minting_price = arg2;
    }

    public fun take_profits(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut Mint, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.profits);
        assert!(v0 > 0, 1);
        0x2::coin::take<0x2::sui::SUI>(&mut arg1.profits, v0, arg2)
    }

    public fun uid_mut(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut Mint) : &mut 0x2::object::UID {
        &mut arg1.id
    }

    public fun update_mixing_limit(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut Mint, arg2: u8) {
        arg1.mixing_limit = arg2;
    }

    // decompiled from Move bytecode v6
}

