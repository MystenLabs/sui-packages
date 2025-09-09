module 0x1bf9a2a82dce754599ec3f73a615500246794241c4385964a6e031331d59be1d::og_dunnies_3rd_map_piece_raffle {
    struct OG_DUNNIES_3RD_MAP_PIECE_RAFFLE has drop {
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

    fun init(arg0: OG_DUNNIES_3RD_MAP_PIECE_RAFFLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<OG_DUNNIES_3RD_MAP_PIECE_RAFFLE>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"OG Dunnies 3rd Map piece Raffle"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"4368617074657220333a2054686520476579736572204d617a65204368616c6c656e676520616e6420746865204372797374616c2043617665726e730a0a496e2074686520706572696c6f757320476579736572204d617a652c207468652044756e6e6965732072656c696564206f6e204a6173706572e280997320736b65746368657320616e64204c756e61e280997320746865726d616c207363616e6e657220746f2061766f69642073756464656e20737465616d206572757074696f6e732e2054686520426c61636b2048617420506972617465204861636b6572207361626f746167656420746865206d617a652c20666f7263696e67207468656d20746f206d6f766520717569636b6c792e204174207468652063656e7465722c204d69636b657920736563757265642074686520666f7572746820535549204e465420667261676d656e742061732064616e67657220636c6f73656420696e20616e6420746865204861636b6572e2809973207461756e74696e6720766f696365206563686f65642061726f756e64207468656d2e0a0a52756e6e696e6720746f20657363617065207468657920676f7420696e746f207468652064617a7a6c696e67204372797374616c2043617665726e7320776865726520696c6c7573696f6e7320616e642068696464656e2074726170732074657374656420746865207465616de280997320666f6375732e204461697379e28099732073746f72696573206b657074207468656972206d696e64732073686172702061732074686579206e617669676174656420746865206465636570746976652070617468732e2041742074686520636f7265206f66207468652063617665726e2c207468657920666f756e642074686520666966746820667261676d656e7420696e73696465206120676c6f77696e67206372797374616c2070696c6c61722e204120686f6c6f6772617068696320677561726469616e207761726e65642c20e2809c4265776172652e20486520697320636f6d696e672ce2809d206a757374206173204c756e6120636f6e6669726d656420746865204861636b65722077617320636c6f73696e6720696e2e20576974682074686520667261676d656e7420696e2068616e642c207468652044756e6e696573207261636564206f6e776172642077697468207468652074696d652072756e6e696e672064616e6765726f75736c792073686f72742e2e2e"));
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

