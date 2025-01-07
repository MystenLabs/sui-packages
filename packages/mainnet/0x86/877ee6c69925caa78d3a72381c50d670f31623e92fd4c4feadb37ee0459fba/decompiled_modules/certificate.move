module 0x86877ee6c69925caa78d3a72381c50d670f31623e92fd4c4feadb37ee0459fba::certificate {
    struct InvestmentCertificate has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image: 0x1::string::String,
        website: 0x1::string::String,
        link: 0x1::string::String,
        description: 0x1::string::String,
        issue_date: u64,
    }

    struct CERTIFICATE has drop {
        dummy_field: bool,
    }

    fun display<T0: key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{link}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{website}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"YouSUI Creator"));
        let v4 = 0x2::display::new_with_fields<T0>(arg0, v0, v2, arg1);
        0x2::display::update_version<T0>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<T0>>(v4, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun get_df_info<T0: store>(arg0: &InvestmentCertificate) : &T0 {
        0x2::dynamic_field::borrow<0x1::string::String, T0>(&arg0.id, 0x1::string::utf8(b"info"))
    }

    public(friend) fun get_mut_df_info<T0: store>(arg0: &mut InvestmentCertificate) : &mut T0 {
        0x2::dynamic_field::borrow_mut<0x1::string::String, T0>(&mut arg0.id, 0x1::string::utf8(b"info"))
    }

    fun init(arg0: CERTIFICATE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CERTIFICATE>(arg0, arg1);
        display<InvestmentCertificate>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun issue_investment_certificate<T0: store>(arg0: &0x2::clock::Clock, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: T0, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg7);
        0x2::dynamic_field::add<0x1::string::String, T0>(&mut v0, 0x1::string::utf8(b"info"), arg6);
        let v1 = InvestmentCertificate{
            id          : v0,
            name        : arg1,
            image       : arg2,
            website     : arg3,
            link        : arg4,
            description : arg5,
            issue_date  : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::transfer::transfer<InvestmentCertificate>(v1, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

