module 0x1c02b9ef97f97705b89187d261f7c3c7e1693951f8be99538b48fb6cc1805945::portfolio {
    struct Portfolio has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        course: 0x1::string::String,
        school: 0x1::string::String,
        about: 0x1::string::String,
        linkedin_url: 0x1::string::String,
        github_url: 0x1::string::String,
        skills: 0x1::string::String,
    }

    struct PORTFOLIO has drop {
        dummy_field: bool,
    }

    public fun create_portfolio(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Portfolio{
            id           : 0x2::object::new(arg8),
            name         : arg1,
            course       : arg2,
            school       : arg3,
            about        : arg4,
            linkedin_url : arg5,
            github_url   : arg6,
            skills       : arg7,
        };
        0x2::transfer::transfer<Portfolio>(v0, arg0);
    }

    fun init(arg0: PORTFOLIO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PORTFOLIO>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"school"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"course"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"linkedin"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"github"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Smart Contracts Code Camp Portfolio of {name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(x"50726f6f66206f66204c6561726e696e6720506f7274666f6c696f2070726f6a6563742070726f75646c79206275696c7420616e64207075626c6973686564207769746820696e666f726d656420636f6e73656e7420647572696e672061204d6f766520536d61727420436f6e74726163747320436f64652043616d7020627920444556434f4e205068696c697070696e657320262053756920466f756e646174696f6e20e2809420776865726520746865207061727469636970616e742077726f74652c207465737465642c20616e64206465706c6f7965642061204d6f766520736d61727420636f6e7472616374206f6e20537569204d61696e6e65742e20546865206f626a656374277320696d6d75746162696c69747920736572766573206f6e6520707572706f73653a20746865207061727469636970616e74277320617574686f727368697020616e642074696d657374616d702063616e6e6f7420626520616c74657265642c2072656d6f7665642c206f7220636c61696d656420627920616e796f6e6520656c73652e"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{school}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{course}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{linkedin_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{github_url}"));
        let v5 = 0x2::display::new_with_fields<Portfolio>(&v0, v1, v3, arg1);
        0x2::display::update_version<Portfolio>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Portfolio>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

