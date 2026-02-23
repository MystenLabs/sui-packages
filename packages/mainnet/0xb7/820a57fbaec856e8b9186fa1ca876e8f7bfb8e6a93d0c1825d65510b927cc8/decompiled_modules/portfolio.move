module 0xb7820a57fbaec856e8b9186fa1ca876e8f7bfb8e6a93d0c1825d65510b927cc8::portfolio {
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
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Proudly built and published during Move Smart Contracts Code Camp by DEVCON Philippines & SUI Foundation"));
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

