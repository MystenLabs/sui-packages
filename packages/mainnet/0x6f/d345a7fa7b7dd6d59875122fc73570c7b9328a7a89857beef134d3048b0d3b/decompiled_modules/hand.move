module 0x6fd345a7fa7b7dd6d59875122fc73570c7b9328a7a89857beef134d3048b0d3b::hand {
    struct HAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"fabdebfa4cb4a5b0c6d0dafe51afdc86c6a7bd0611396b61d134c88ce5e54c57                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HAND>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HAND        ")))), trim_right(b"TRUMPHAND                       "), trim_right(x"5452554d5048414e4420282448414e442920697320746865206d656d6520636f696e20626f726e2066726f6d206272756973657320627574206275696c7420666f7220746865206d6f6f6e2e200a54686579206c617567686564206174207468652068616e642c2074686579206d6f636b656420746865206272756973652020627574206e6f77206974732074696d6520746f20666c697020746865207363726970742e0a2448414e4420726570726573656e7473206469616d6f6e642068616e64732077697468206d656d6520706f7765722c207475726e696e67207765616b6e65737320696e746f20737472656e67746820616e642046554420696e746f20464f4d4f2e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAND>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAND>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

