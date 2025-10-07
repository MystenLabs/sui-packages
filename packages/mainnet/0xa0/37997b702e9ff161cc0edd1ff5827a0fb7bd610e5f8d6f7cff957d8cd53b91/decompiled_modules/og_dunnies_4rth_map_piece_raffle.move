module 0xa037997b702e9ff161cc0edd1ff5827a0fb7bd610e5f8d6f7cff957d8cd53b91::og_dunnies_4rth_map_piece_raffle {
    struct OG_DUNNIES_4RTH_MAP_PIECE_RAFFLE has drop {
        dummy_field: bool,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun create_nft_with_verification(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x95e360f56458bf2862cd983b63aaa23e43997674eda99f28541cca1adfa44f50::launchpad::Verification, arg6: &mut 0x2::tx_context::TxContext) : Nft {
        let v0 = Nft{
            id          : 0x2::object::new(arg6),
            name        : arg0,
            description : arg1,
            media_url   : arg2,
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg3, arg4),
        };
        0x95e360f56458bf2862cd983b63aaa23e43997674eda99f28541cca1adfa44f50::launchpad::set_verification_nft_id(arg5, 0x2::object::id<Nft>(&v0));
        v0
    }

    fun init(arg0: OG_DUNNIES_4RTH_MAP_PIECE_RAFFLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<OG_DUNNIES_4RTH_MAP_PIECE_RAFFLE>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"OG Dunnies 4rth Map piece Raffle"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"417420746865204865617274206f6620432e412e422e412e442e2c207468652044756e6e6965732066616365642074686520426c61636b204861742020506972617465204861636b657220696e20612066696e616c2073686f77646f776e2e20497420776173206c617465206174206e69676874207768656e20686520756e6c656173686564206869732066756c6c207465636820617273656e616c2c20627574207468652044756e6e69657320776f726b656420746f67657468657220616e642064657374726f7965642068696d21204c756e61206861636b6564206869732073797374656d732c204b69702064697374726163746564207468652064726f6e65732c204a6173706572206d617070656420746865697220706174682c20616e64204d69636b6579206c6564207468656d207468726f75676820746865206368616f732e0a5265616368696e672074686520636f72652c204d69636b657920747269656420746f20706c6163652074686520535549204e465420667261676d656e747320696e20612072616e646f6d20676174652c207768656e2073756464656e6c79206120686f6c6f6772616d206170706561726564207769746820746865206e756d62657220313131312e2044756e6e696573207265616c697a656420746861742074686579206861766520746f2066696e6420746865206761746520776974682074686174206e756d6265722e20416674657220736561726368696e6720666f722061207768696c652c20746865792066696e6420746865206761746520616e64204d69636b657920706c616365642074686520535549204e465420667261676d656e747320726573746f72696e67207468652069736c616e64e280997320706f77657220616e6420646973736f6c76696e6720746865204861636b6572e2809973207465636821"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"ipfs://bafkreiflzoynrf3n4inj2p47gul3v3h75ritrb6qxbqqd25mupbbv4decq"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{media_url}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"media_url"), 0x1::string::utf8(b"{media_url}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<Nft>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<Nft>(&v0, arg1);
        let v4 = v3;
        let v5 = v2;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Nft>(&mut v5, &v4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Nft>(&mut v5, &v4, 500, 0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Nft>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft>>(v5);
    }

    public fun update_nft_with_verification(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: &0x95e360f56458bf2862cd983b63aaa23e43997674eda99f28541cca1adfa44f50::launchpad::Verification, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap) {
        assert!(0x95e360f56458bf2862cd983b63aaa23e43997674eda99f28541cca1adfa44f50::launchpad::get_verification_nft_id(arg6) == arg0, 1);
        let v0 = 0x2::kiosk::borrow_mut<Nft>(arg7, arg8, arg0);
        v0.name = arg1;
        v0.description = arg2;
        v0.media_url = arg3;
        v0.attributes = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

