module 0xc25695f9d738f52b9bd6946c65e9490e0bfc59ae70e6c80ab64eadbbb4b68c4a::n1 {
    struct N1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: N1, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7JTHgyBDLqZMb22wnw9mA6fvCSrQFV5pvELjfXKApump.png?claimId=LNYYsh5WKz4U5QNy                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<N1>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"N1          ")))), trim_right(b"N1 IMPLANT NEURALINK            "), trim_right(b"The US Food and Drug Administration (FDA) has cleared Elon Musk's company Neuralink to conduct human clinical trials. The N1 chip allows brain signals to be transmitted via Bluetooth, allowing you to control a computer or smartphone directly using your brain impulses $N1                                                 "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<N1>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<N1>>(v4);
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

