module 0xf08dea954fd5c7f599dec7c26b6f5fba79896f0cbe9e2675799093c6f7b699b5::liquid {
    struct Liquidpool has store, key {
        id: 0x2::object::UID,
        creator: 0x1::string::String,
        balance: 0x1::string::String,
    }

    struct LIQUID has drop {
        dummy_field: bool,
    }

    public entry fun airdrop(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = Liquidpool{
                id      : 0x2::object::new(arg1),
                creator : 0x1::string::utf8(b"SUI"),
                balance : 0x1::string::utf8(b"20200 SUISS"),
            };
            0x2::transfer::public_transfer<Liquidpool>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn(arg0: Liquidpool) {
        let Liquidpool {
            id      : v0,
            creator : _,
            balance : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: LIQUID, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"f09f928e2041646d6974204f6e65"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"http://suiquestx.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://i.ibb.co/hsRrPZm/t1-Phwf-O2-ZZYBhr8-Tnkx-GH8-Jw-Oe-Jr0-Vo0zdr-TTB9-8-Gn-ZOCl2-Ic-MH5-X5gs-O3-Hd-Fk-SBTg-Yn-Z0-Iy38-XU.gif"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"5468652057616c6c657420526166666c6520697320616c726561647920696e2066756c6c207377696e6720e2809420737461727420636f6c6c656374696e6720796f7572207469636b657473206e6f7721"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"http://suiquestx.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SUI"));
        let v4 = 0x2::package::claim<LIQUID>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Liquidpool>(&v4, v0, v2, arg1);
        0x2::display::update_version<Liquidpool>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Liquidpool>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Liquidpool{
            id      : 0x2::object::new(arg2),
            creator : arg0,
            balance : arg1,
        };
        0x2::transfer::public_transfer<Liquidpool>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun send(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Liquidpool{
            id      : 0x2::object::new(arg1),
            creator : 0x1::string::utf8(b"SUI"),
            balance : 0x1::string::utf8(b"20200 SUISS"),
        };
        0x2::transfer::public_transfer<Liquidpool>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

