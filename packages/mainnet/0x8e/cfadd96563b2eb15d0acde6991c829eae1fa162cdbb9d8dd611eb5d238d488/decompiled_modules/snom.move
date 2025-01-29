module 0x8ecfadd96563b2eb15d0acde6991c829eae1fa162cdbb9d8dd611eb5d238d488::snom {
    struct SNOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"https://gateway.pinata.cloud/ipfs/bafkreihysoeup24rpunjfx4ordfh7fjx5lhi7rwpkjpi56xlrptdhhh7oq                                                                                                                                                                                                                                   ");
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<SNOM>(arg0, 9, 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SNOM    ")))), trim_right(b"SaNom                           "), trim_right(b"A digital asset designed to enhance player interaction reward participation and drive engagement within gaming ecosystems These tokens can be used for in game purchases unlocking exclusive content earning rewards or even facilitating player driven economies With blockchain integration they offer transparency           "), v1, arg1);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<SNOM>>(0x2::coin::mint<SNOM>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SNOM>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNOM>>(v3);
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

