module 0x4c9e9bd7cade82b7ff4a1a100c13ae6e3b84279e6bb19404b9088778a12230c2::crush_chad {
    struct CRUSH_CHAD has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CrushChad has store, key {
        id: 0x2::object::UID,
        token_id: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        rarity: 0x1::string::String,
        crush_count: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun airdrop_to_kiosk(arg0: &AdminCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Rarity"), 0x1::string::utf8(b"Chad"));
        let v1 = CrushChad{
            id          : 0x2::object::new(arg6),
            token_id    : arg3,
            name        : 0x1::string::utf8(arg4),
            image_url   : 0x1::string::utf8(arg5),
            rarity      : 0x1::string::utf8(b"Chad"),
            crush_count : 0,
            attributes  : v0,
        };
        0x2::kiosk::place<CrushChad>(arg1, arg2, v1);
    }

    public fun crush_count(arg0: &CrushChad) : u64 {
        arg0.crush_count
    }

    public fun increment_crush_count(arg0: &mut CrushChad) {
        arg0.crush_count = arg0.crush_count + 1;
    }

    fun init(arg0: CRUSH_CHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CRUSH_CHAD>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{rarity}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://scamcrusher.wal.app"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Scam Crusher Chad NFT - Exclusive 1/1 collection"));
        let v5 = 0x2::display::new_with_fields<CrushChad>(&v0, v1, v3, arg1);
        0x2::display::update_version<CrushChad>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<CrushChad>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CrushChad>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<CrushChad>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<CrushChad>>(v6);
        let v8 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v8, 0x2::tx_context::sender(arg1));
    }

    public fun update_name(arg0: &AdminCap, arg1: &mut CrushChad, arg2: vector<u8>) {
        arg1.name = 0x1::string::utf8(arg2);
    }

    // decompiled from Move bytecode v7
}

