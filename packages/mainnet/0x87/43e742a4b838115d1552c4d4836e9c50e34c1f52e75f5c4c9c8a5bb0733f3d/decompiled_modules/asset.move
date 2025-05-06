module 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::asset {
    struct AssetAlloc has copy, drop {
        asset: address,
        fot: address,
        shares: u64,
    }

    struct AssetTransfer has copy, drop {
        sender: address,
        recipient: address,
        asset: address,
        fot: address,
        shares: u64,
    }

    struct FOT has store, key {
        id: 0x2::object::UID,
        asset: address,
        shares: u64,
    }

    struct Asset<T0: store> has store, key {
        id: 0x2::object::UID,
        network: address,
        asset_type: 0x1::string::String,
        asset_sn: 0x1::string::String,
        ctrl: u64,
        committee: 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::committee::Committee,
        asset: T0,
        shares_total: u64,
        shares_alloc: u64,
    }

    public fun assert_asset_fot_match(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 88887001);
    }

    public fun asset_borrow<T0: store>(arg0: &Asset<T0>) : &T0 {
        &arg0.asset
    }

    public fun asset_borrow_mut<T0: store>(arg0: &mut Asset<T0>) : &mut T0 {
        &mut arg0.asset
    }

    public fun asset_fot_alloc<T0: store>(arg0: &mut Asset<T0>, arg1: u64, arg2: address, arg3: u16, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 88887003);
        assert!(arg0.shares_total >= arg1, 88887002);
        let v0 = 0x2::object::id_address<Asset<T0>>(arg0);
        let v1 = FOT{
            id     : 0x2::object::new(arg5),
            asset  : v0,
            shares : arg1,
        };
        arg0.shares_alloc = arg0.shares_alloc + arg1;
        0x2::transfer::public_transfer<FOT>(v1, arg2);
        let v2 = AssetAlloc{
            asset  : v0,
            fot    : 0x2::object::id_address<FOT>(&v1),
            shares : arg1,
        };
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::event::emit<AssetAlloc>(arg3, 0x1::string::utf8(arg4), v2);
    }

    public fun asset_fot_transfer(arg0: &mut FOT, arg1: u64, arg2: address, arg3: u16, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 88887003);
        assert!(arg0.shares >= arg1, 88887002);
        let v0 = FOT{
            id     : 0x2::object::new(arg5),
            asset  : arg0.asset,
            shares : arg1,
        };
        arg0.shares = arg0.shares - arg1;
        0x2::transfer::public_transfer<FOT>(v0, arg2);
        let v1 = AssetTransfer{
            sender    : 0x2::tx_context::sender(arg5),
            recipient : arg2,
            asset     : arg0.asset,
            fot       : 0x2::object::id_address<FOT>(&v0),
            shares    : arg1,
        };
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::event::emit<AssetTransfer>(arg3, 0x1::string::utf8(arg4), v1);
    }

    public fun asset_sn_borrow<T0: store>(arg0: &Asset<T0>) : 0x1::string::String {
        arg0.asset_sn
    }

    public fun asset_type_borrow<T0: store>(arg0: &Asset<T0>) : 0x1::string::String {
        arg0.asset_type
    }

    public fun committee_borrow<T0: store>(arg0: &Asset<T0>) : &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::committee::Committee {
        &arg0.committee
    }

    public fun committee_borrow_mut<T0: store>(arg0: &mut Asset<T0>) : &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::committee::Committee {
        &mut arg0.committee
    }

    public fun create_asset<T0: store>(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::network::Network, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: T0, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 88887003);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::network::fee(arg0, 10);
        let v0 = Asset<T0>{
            id           : 0x2::object::new(arg7),
            network      : 0x2::object::id_address<0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::network::Network>(arg0),
            asset_type   : 0x1::string::utf8(arg1),
            asset_sn     : 0x1::string::utf8(arg2),
            ctrl         : arg3,
            committee    : 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::committee::new(arg7),
            asset        : arg5,
            shares_total : arg4,
            shares_alloc : 0,
        };
        0x2::transfer::public_transfer<Asset<T0>>(v0, arg6);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::event::emit_asset_born_event(0x2::object::id_address<Asset<T0>>(&v0));
    }

    public fun ctrl_borrow<T0: store>(arg0: &Asset<T0>) : u64 {
        arg0.ctrl
    }

    public fun network_borrow<T0: store>(arg0: &Asset<T0>) : address {
        arg0.network
    }

    public fun set_asset_sn<T0: store>(arg0: &mut Asset<T0>, arg1: 0x1::string::String) {
        arg0.asset_sn = arg1;
    }

    public fun set_asset_type<T0: store>(arg0: &mut Asset<T0>, arg1: 0x1::string::String) {
        arg0.asset_type = arg1;
    }

    public fun set_ctrl<T0: store>(arg0: &mut Asset<T0>, arg1: u64) {
        arg0.ctrl = arg1;
    }

    public fun set_network<T0: store>(arg0: &mut Asset<T0>, arg1: address) {
        arg0.network = arg1;
    }

    public fun set_publisher<T0: store>(arg0: Asset<T0>, arg1: address) {
        0x2::transfer::public_transfer<Asset<T0>>(arg0, arg1);
    }

    public fun set_shares_total<T0: store>(arg0: &mut Asset<T0>, arg1: u64) {
        arg0.shares_total = arg1;
    }

    public fun shares_alloc_borrow<T0: store>(arg0: &Asset<T0>) : u64 {
        arg0.shares_alloc
    }

    public fun shares_total_borrow<T0: store>(arg0: &Asset<T0>) : u64 {
        arg0.shares_total
    }

    // decompiled from Move bytecode v6
}

