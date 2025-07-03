module 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila {
    struct KILA has drop {
        dummy_field: bool,
    }

    struct Kila has store, key {
        id: 0x2::object::UID,
        number: u16,
        image: 0x1::string::String,
        minted_by: 0x1::option::Option<address>,
        upgraded_by: 0x1::option::Option<address>,
        attributes: Attributes,
        project_url: 0x1::option::Option<0x1::string::String>,
    }

    struct Attributes has copy, drop, store {
        background: 0x1::string::String,
        body: 0x1::string::String,
        hair: 0x1::string::String,
        face: 0x1::string::String,
        clothes: 0x1::string::String,
        hat: 0x1::string::String,
        eye: 0x1::string::String,
    }

    struct KilaPfps has key {
        id: 0x2::object::UID,
        pfps: 0x2::object_table::ObjectTable<u16, Kila>,
        is_initialized: bool,
    }

    fun change_attributes(arg0: &mut Kila, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String) {
        let v0 = Attributes{
            background : arg1,
            body       : arg2,
            hair       : arg3,
            face       : arg4,
            clothes    : arg5,
            hat        : arg6,
            eye        : arg7,
        };
        arg0.attributes = v0;
    }

    fun change_image(arg0: &mut Kila, arg1: 0x1::string::String) {
        arg0.image = arg1;
    }

    public(friend) fun get_pfp_attributes(arg0: &Kila) : Attributes {
        arg0.attributes
    }

    public(friend) fun get_pfp_number(arg0: &Kila) : u16 {
        arg0.number
    }

    public(friend) fun get_upgraded_by(arg0: &Kila) : address {
        *0x1::option::borrow<address>(&arg0.upgraded_by)
    }

    fun init(arg0: KILA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<KILA>(arg0, arg1);
        let v1 = 0x2::display::new<Kila>(&v0, arg1);
        0x2::display::add<Kila>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Kila #{number}"));
        0x2::display::add<Kila>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Join the pod with unique art hundreds of traits influenced by meme culture on sui."));
        0x2::display::add<Kila>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image}"));
        0x2::display::add<Kila>(&mut v1, 0x1::string::utf8(b"minted_by"), 0x1::string::utf8(b"{minted_by}"));
        0x2::display::add<Kila>(&mut v1, 0x1::string::utf8(b"upgraded_by"), 0x1::string::utf8(b"{upgraded_by}"));
        0x2::display::add<Kila>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<Kila>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"killa-coin.wal.app"));
        0x2::display::update_version<Kila>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<Kila>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Kila>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Kila>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Kila>>(v2);
    }

    public(friend) fun make_pfp(arg0: u16, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) : Kila {
        let v0 = Attributes{
            background : arg2,
            body       : arg3,
            hair       : arg4,
            face       : arg5,
            clothes    : arg6,
            hat        : arg7,
            eye        : arg8,
        };
        Kila{
            id          : 0x2::object::new(arg9),
            number      : arg0,
            image       : arg1,
            minted_by   : 0x1::option::none<address>(),
            upgraded_by : 0x1::option::none<address>(),
            attributes  : v0,
            project_url : 0x1::option::none<0x1::string::String>(),
        }
    }

    public(friend) fun set_minted_by(arg0: &mut Kila, arg1: address) {
        0x1::option::fill<address>(&mut arg0.minted_by, arg1);
    }

    public(friend) fun upgrade_pfp(arg0: &mut Kila, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<address>(&arg0.upgraded_by), 4);
        change_attributes(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        change_image(arg0, arg1);
        0x1::option::fill<address>(&mut arg0.upgraded_by, 0x2::tx_context::sender(arg9));
    }

    // decompiled from Move bytecode v6
}

