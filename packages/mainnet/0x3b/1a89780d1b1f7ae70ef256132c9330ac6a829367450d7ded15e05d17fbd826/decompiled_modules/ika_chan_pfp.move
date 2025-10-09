module 0x3b1a89780d1b1f7ae70ef256132c9330ac6a829367450d7ded15e05d17fbd826::ika_chan_pfp {
    struct IkaChanAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct IKA_CHAN_PFP has drop {
        dummy_field: bool,
    }

    struct Metadata has drop, store {
        background: 0x1::string::String,
        eyes: 0x1::string::String,
        mouth: 0x1::string::String,
        hair: 0x1::string::String,
        hat: 0x1::string::String,
        back_item: 0x1::string::String,
        cloth: 0x1::string::String,
        number: u64,
        blob: 0x1::string::String,
    }

    struct IkaChan has store, key {
        id: 0x2::object::UID,
        metadata: Metadata,
    }

    public fun new(arg0: Metadata, arg1: &mut 0x2::tx_context::TxContext) : IkaChan {
        IkaChan{
            id       : 0x2::object::new(arg1),
            metadata : arg0,
        }
    }

    public fun id(arg0: &IkaChan) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: IKA_CHAN_PFP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = IkaChanAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<IkaChanAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x2::package::claim<IKA_CHAN_PFP>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"id"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"background"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"eyes"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"mouth"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"hair"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"hat"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"back_item"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"cloth"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{id}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"IkaChan #{metadata.number}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Ika-chan PFP"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{metadata.blob}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"dWallet Labs"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://mfsmnft.wal.app/"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{metadata.background}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{metadata.eyes}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{metadata.mouth}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{metadata.hair}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{metadata.hat}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{metadata.back_item}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{metadata.cloth}"));
        let v6 = 0x2::display::new_with_fields<IkaChan>(&v1, v2, v4, arg1);
        0x2::display::update_version<IkaChan>(&mut v6);
        let (v7, v8) = 0x2::transfer_policy::new<IkaChan>(&v1, arg1);
        let v9 = v8;
        let v10 = v7;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<IkaChan>(&mut v10, &v9, 690, 0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<IkaChan>(&mut v10, &v9);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::add<IkaChan>(&mut v10, &v9);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<IkaChan>>(v10);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<IkaChan>>(v9, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<IkaChan>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun new_metadata(arg0: &IkaChanAdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: 0x1::string::String) : Metadata {
        Metadata{
            background : arg1,
            eyes       : arg2,
            mouth      : arg3,
            hair       : arg4,
            hat        : arg5,
            back_item  : arg6,
            cloth      : arg7,
            number     : arg8,
            blob       : arg9,
        }
    }

    // decompiled from Move bytecode v6
}

