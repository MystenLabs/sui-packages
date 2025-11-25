module 0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt {
    struct AlphaFiReceipt has key {
        id: 0x2::object::UID,
        position_pool_map: 0x2::vec_map::VecMap<0x2::object::ID, PositionInfo>,
        client_address: address,
        image_url: 0x1::string::String,
    }

    struct PositionInfo has store {
        pool_id: 0x2::object::ID,
        partner_cap_id: 0x2::object::ID,
    }

    struct WhiteListedAddressForTransfer has store, key {
        id: 0x2::object::UID,
        addresses: 0x2::vec_set::VecSet<address>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PartnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct ALPHAFI_RECEIPT has drop {
        dummy_field: bool,
    }

    public fun add_admin(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<AdminCap>(v0, arg1);
    }

    public fun add_position(arg0: &mut AlphaFiReceipt, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &PartnerCap) {
        assert!(!0x2::vec_map::contains<0x2::object::ID, PositionInfo>(&arg0.position_pool_map, &arg1), 0);
        let v0 = PositionInfo{
            pool_id        : arg2,
            partner_cap_id : 0x2::object::id<PartnerCap>(arg3),
        };
        0x2::vec_map::insert<0x2::object::ID, PositionInfo>(&mut arg0.position_pool_map, arg1, v0);
    }

    public fun add_white_listed_address(arg0: &mut WhiteListedAddressForTransfer, arg1: &AdminCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.addresses, arg2);
    }

    public fun create_alphafi_receipt(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AlphaFiReceipt{
            id                : 0x2::object::new(arg1),
            position_pool_map : 0x2::vec_map::empty<0x2::object::ID, PositionInfo>(),
            client_address    : 0x2::tx_context::sender(arg1),
            image_url         : 0x1::string::utf8(arg0),
        };
        0x2::transfer::transfer<AlphaFiReceipt>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun create_alphafi_receipt_v2(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : AlphaFiReceipt {
        AlphaFiReceipt{
            id                : 0x2::object::new(arg1),
            position_pool_map : 0x2::vec_map::empty<0x2::object::ID, PositionInfo>(),
            client_address    : 0x2::tx_context::sender(arg1),
            image_url         : 0x1::string::utf8(arg0),
        }
    }

    public fun create_partner_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : PartnerCap {
        PartnerCap{id: 0x2::object::new(arg1)}
    }

    fun init(arg0: ALPHAFI_RECEIPT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"AlphaFi-Receipt"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"AlphaFi-Receipt Protocol Receipt Capability"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"AlphaFi-Receipt"));
        let v4 = 0x2::package::claim<ALPHAFI_RECEIPT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<AlphaFiReceipt>(&v4, v0, v2, arg1);
        let v6 = WhiteListedAddressForTransfer{
            id        : 0x2::object::new(arg1),
            addresses : 0x2::vec_set::empty<address>(),
        };
        0x2::display::update_version<AlphaFiReceipt>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<AlphaFiReceipt>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<WhiteListedAddressForTransfer>(v6);
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v7, 0x2::tx_context::sender(arg1));
    }

    public fun remove_position(arg0: &mut AlphaFiReceipt, arg1: 0x2::object::ID, arg2: &PartnerCap) {
        assert!(0x2::vec_map::contains<0x2::object::ID, PositionInfo>(&arg0.position_pool_map, &arg1), 1);
        assert!(0x2::vec_map::get<0x2::object::ID, PositionInfo>(&arg0.position_pool_map, &arg1).partner_cap_id == 0x2::object::id<PartnerCap>(arg2), 3);
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, PositionInfo>(&mut arg0.position_pool_map, &arg1);
        let PositionInfo {
            pool_id        : _,
            partner_cap_id : _,
        } = v1;
    }

    public fun transfer_receipt_to_new_owner(arg0: AlphaFiReceipt, arg1: address, arg2: &mut WhiteListedAddressForTransfer, arg3: &mut 0x2::tx_context::TxContext) {
        verify_owner(&arg0, arg3);
        let v0 = arg0.client_address;
        if (arg1 != v0) {
            assert!(0x2::vec_set::contains<address>(&arg2.addresses, &v0), 5);
            arg0.client_address = arg1;
            0x2::vec_set::remove<address>(&mut arg2.addresses, &v0);
        };
        0x2::transfer::transfer<AlphaFiReceipt>(arg0, arg1);
    }

    fun verify_owner(arg0: &AlphaFiReceipt, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.client_address == 0x2::tx_context::sender(arg1), 6);
    }

    public fun verify_position(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &AlphaFiReceipt, arg3: &0x2::tx_context::TxContext) {
        verify_owner(arg2, arg3);
        assert!(0x2::vec_map::contains<0x2::object::ID, PositionInfo>(&arg2.position_pool_map, &arg0), 1);
        assert!(0x2::vec_map::get<0x2::object::ID, PositionInfo>(&arg2.position_pool_map, &arg0).pool_id == arg1, 2);
    }

    // decompiled from Move bytecode v6
}

