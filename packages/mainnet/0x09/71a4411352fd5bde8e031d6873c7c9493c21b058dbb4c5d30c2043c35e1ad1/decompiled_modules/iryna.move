module 0x971a4411352fd5bde8e031d6873c7c9493c21b058dbb4c5d30c2043c35e1ad1::iryna {
    struct IRYNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRYNA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"d576e6ba778fb602ddd82be6bf8d9c0860ce43cd8418ca605d12a193d281468a                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<IRYNA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"IRYNA       ")))), trim_right(b"Justice for Iryna               "), trim_right(x"4a75737469636520666f72204972796e61210a0a4f6e204175677573742032322c20323032352c204972796e61205a61727574736b6120612032332d796561722d6f6c6420556b7261696e69616e20726566756765652077686f20666c65642077617220696e20736561726368206f6620736166657479207761732073656e73656c6573736c79207374616262656420746f206465617468206279206120737472616e6765722061626f617264206120436861726c6f747465206c696768742d7261696c20747261696e2e205468652061747461636b207761732072616e646f6d20616e6420756e70726f766f6b65643b20666f6f746167652063617074757265642074686520686f72726f72206173207368652077617320737461626265642074687265652074696d657320696e20746865206e65636b20616e6420636865"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRYNA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IRYNA>>(v4);
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

