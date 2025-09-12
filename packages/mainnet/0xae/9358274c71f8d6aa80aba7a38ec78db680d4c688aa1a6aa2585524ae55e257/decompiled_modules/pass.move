module 0xbd86ff024c863d7708a9386505977b42170243213df3b943435815c006a9247e::pass {
    struct BykaPass has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == 1000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, @0x7028d6878ed305e86ae423fe2d3b2f2c4a4525989a8d58ab26bb050dfce3e41a);
        let v0 = BykaPass{
            id          : 0x2::object::new(arg4),
            title       : arg0,
            description : arg1,
            image_url   : arg2,
        };
        0x2::transfer::public_transfer<BykaPass>(v0, 0x2::tx_context::sender(arg4));
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &BykaPass) {
    }

    // decompiled from Move bytecode v6
}

