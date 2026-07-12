module 0x5ce3fdc5071413671ed1724cca2c08bffe5d6d7b805e84c4652daf0c5ee74f0e::crush_whale {
    struct CRUSH_WHALE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CrushWhale has store, key {
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
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Rarity"), 0x1::string::utf8(b"Whale"));
        let v1 = CrushWhale{
            id          : 0x2::object::new(arg6),
            token_id    : arg3,
            name        : 0x1::string::utf8(arg4),
            image_url   : 0x1::string::utf8(arg5),
            rarity      : 0x1::string::utf8(b"Whale"),
            crush_count : 0,
            attributes  : v0,
        };
        0x2::kiosk::place<CrushWhale>(arg1, arg2, v1);
    }

    public fun crush_count(arg0: &CrushWhale) : u64 {
        arg0.crush_count
    }

    public fun increment_crush_count(arg0: &mut CrushWhale) {
        arg0.crush_count = arg0.crush_count + 1;
    }

    fun init(arg0: CRUSH_WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CRUSH_WHALE>(arg0, arg1);
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
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Scam Crusher Whale NFT - Exclusive 1/1 collection"));
        let v5 = 0x2::display::new_with_fields<CrushWhale>(&v0, v1, v3, arg1);
        0x2::display::update_version<CrushWhale>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<CrushWhale>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CrushWhale>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<CrushWhale>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<CrushWhale>>(v6);
        let v8 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v8, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

