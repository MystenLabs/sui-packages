module 0x27c221c48abe6a4371c3f000a090851b13e48e5aac9c150f4250eb6a2d1ed770::stamp {
    struct Stamp has key {
        id: 0x2::object::UID,
        dao_fund_id: 0x2::object::ID,
        image_url: 0x2::url::Url,
        assets: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    struct StampMintedEvent has copy, drop {
        stamp_id: 0x2::object::ID,
        dao_fund_id: 0x2::object::ID,
        assets: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    struct StampAssetRemovedEvent has copy, drop {
        stamp_id: 0x2::object::ID,
        dao_fund_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct StampBurnedEvent has copy, drop {
        stamp_id: 0x2::object::ID,
        dao_fund_id: 0x2::object::ID,
    }

    struct STAMP has drop {
        dummy_field: bool,
    }

    public(friend) fun transfer(arg0: Stamp, arg1: address) {
        0x2::transfer::transfer<Stamp>(arg0, arg1);
    }

    public(friend) fun burn_and_emit(arg0: Stamp) {
        assert!(0x2::vec_map::is_empty<0x1::ascii::String, u64>(&arg0.assets), 2000);
        let v0 = StampBurnedEvent{
            stamp_id    : 0x2::object::id<Stamp>(&arg0),
            dao_fund_id : arg0.dao_fund_id,
        };
        0x2::event::emit<StampBurnedEvent>(v0);
        let Stamp {
            id          : v1,
            dao_fund_id : _,
            image_url   : _,
            assets      : v4,
        } = arg0;
        0x2::vec_map::destroy_empty<0x1::ascii::String, u64>(v4);
        0x2::object::delete(v1);
    }

    public(friend) fun get_amount_by_coin_type(arg0: &Stamp, arg1: 0x1::ascii::String) : u64 {
        *0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.assets, &arg1)
    }

    fun init(arg0: STAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Suidaos Stamp NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Suidaos Stamp NFT"));
        let v4 = 0x2::package::claim<STAMP>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Stamp>(&v4, v0, v2, arg1);
        0x2::display::update_version<Stamp>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Stamp>>(v5, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint_and_emit(arg0: 0x2::object::ID, arg1: 0x2::vec_map::VecMap<0x1::ascii::String, u64>, arg2: &mut 0x2::tx_context::TxContext) : Stamp {
        let v0 = Stamp{
            id          : 0x2::object::new(arg2),
            dao_fund_id : arg0,
            image_url   : 0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLK2IrzRcJe2AnqE5MbsrmIBrm0gzhAzY-cw&s"),
            assets      : arg1,
        };
        let v1 = StampMintedEvent{
            stamp_id    : 0x2::object::id<Stamp>(&v0),
            dao_fund_id : arg0,
            assets      : arg1,
        };
        0x2::event::emit<StampMintedEvent>(v1);
        v0
    }

    public(friend) fun remove_asset(arg0: Stamp, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StampAssetRemovedEvent{
            stamp_id    : 0x2::object::id<Stamp>(&arg0),
            dao_fund_id : arg0.dao_fund_id,
            coin_type   : arg1,
            amount      : *0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.assets, &arg1),
        };
        0x2::event::emit<StampAssetRemovedEvent>(v0);
        let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.assets, &arg1);
        if (0x2::vec_map::is_empty<0x1::ascii::String, u64>(&arg0.assets)) {
            burn_and_emit(arg0);
        } else {
            transfer(arg0, 0x2::tx_context::sender(arg2));
        };
    }

    // decompiled from Move bytecode v6
}

