module 0xe535dd212cde2b14312185e4d3e44a5a1d817bdc1c297a9acdfffcdaa15e625b::pumpt {
    struct PUMPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"f295762e45e6d52e41b158bac047c563ff8c5c6130410b3ff4eeea5b35a972af                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PUMPT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Pumpt       ")))), trim_right(b"Mr Pumpt                        "), trim_right(x"496e2074686520626567696e6e696e672c20746865726520776173207468652070756d702e0a5468656e2063616d65204d722050756d707420207468652063686f73656e206f6e652e0a48652073617720746865206368617274732c20616e64207468657920726f73652e0a48652073617720746865206469702c20616e6420686520626f75676874206d6f72652e0a4d722050756d707420646f65736e74206368617365207468652070756d70206865206973207468652070756d702e0a4c6f76652068696d2e2042652068696d2e204c6976652068696d2e0a4c6f6e67206c6976652050554d50542020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPT>>(v4);
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

