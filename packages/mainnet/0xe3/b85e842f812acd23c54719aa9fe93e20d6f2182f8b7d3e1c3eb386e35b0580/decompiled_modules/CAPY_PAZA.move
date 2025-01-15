module 0xe3b85e842f812acd23c54719aa9fe93e20d6f2182f8b7d3e1c3eb386e35b0580::CAPY_PAZA {
    struct CAPY_PAZA has drop {
        dummy_field: bool,
    }

    struct CAPY has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: CAPY_PAZA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"CAPY CAPY"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.google.com/imgres?q=capybara&imgurl=https%3A%2F%2Fimgcdn.stablediffusionweb.com%2F2024%2F4%2F18%2F2ee4dea5-0569-4492-b31d-fa7cf4ef5083.jpg&imgrefurl=https%3A%2F%2Fstablediffusionweb.com%2Fvi%2Fimage%2F5571938-green-haired-cute-capybara&docid=Zzy_R5IC3mSVHM&tbnid=qZe71FZ-N0VyeM&vet=12ahUKEwjuqpO9vfeKAxWOnK8BHfhgFd0QM3oECD8QAA..i&w=1024&h=1024&hcb=2&ved=2ahUKEwjuqpO9vfeKAxWOnK8BHfhgFd0QM3oECD8QAA"));
        let v4 = 0x2::package::claim<CAPY_PAZA>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<CAPY>(&v4, v0, v2, arg1);
        0x2::display::update_version<CAPY>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CAPY>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CAPY{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<CAPY>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

