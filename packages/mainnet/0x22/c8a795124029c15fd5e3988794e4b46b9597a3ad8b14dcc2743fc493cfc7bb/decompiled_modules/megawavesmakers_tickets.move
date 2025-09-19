module 0x22c8a795124029c15fd5e3988794e4b46b9597a3ad8b14dcc2743fc493cfc7bb::megawavesmakers_tickets {
    struct MEGAWAVESMAKERS_TICKETS has drop {
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

    fun init(arg0: MEGAWAVESMAKERS_TICKETS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MEGAWAVESMAKERS_TICKETS>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"MegaWavesMakers Tickets"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"4d656761706f6e740ae280a669732061206d756c7469636861696e20706978656c20617274206272616e64206578706572696d656e74696e672077697468204e465420746563686e6f6c6f67792e205765206578706c6f7265206279206372656174696e672ee280a8546869732074696d6520776520646973636f766572207468652053756920626c6f636b636861696e2c20706c6163696e67206f7572206d756c7469766572736520706f7274616c20686572652ee280a8416e64206f7572204d65676157617665734d616b6572732077696c6c2067756172642069742e0a0a4d65676157617665734d616b6572730ae280a6697320616e206578706572696d656e74616c206f6e636861696e2064796e616d696320706978656c206172742050465020636f6c6c656374696f6e20776974682067616d6966696564206d656368616e696373206f662070756c6c696e67207472616974732066726f6d206120636f6d6d6f6e20706f6f6c2ee280a8547261697473206172652073706c697420696e746f2067726f7570733a0a2a205075626c69632074726169747320e2809320617661696c61626c6520666f722065766572796f6e652e0a2a2046616374696f6e2074726169747320e280932061636365737369626c65206f6e6c7920746f206d656d62657273206f662073706563696669632066616374696f6e732c20726570726573656e74696e6720746f7020636f6d6d756e6974696573206f6e207468652053756920626c6f636b636861696e2e0a45616368204d65676157617665734d616b6572206973206e6f7420666978656420e280942069742065766f6c766573207468726f7567682072616964732c2070756c6c732c20616e64207374726174656769632063686f696365732e0a0a5468697320697320636f6c6c656374696f6e206f66207469636b6574732e204d65676157617665734d616b657273204e46542077696c6c2062652061697264726f7070656420746f207469636b65747320686f6c6465727320696e206120646179206166746572206d696e742e"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"ipfs://bafkreihadytlucputubtwtsa47uedwogrru2h53nwt3lvbwuzvbst5ekny"));
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
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Nft>(&mut v5, &v4, 300, 0);
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

