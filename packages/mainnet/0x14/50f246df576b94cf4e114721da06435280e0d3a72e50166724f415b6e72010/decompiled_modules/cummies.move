module 0x1450f246df576b94cf4e114721da06435280e0d3a72e50166724f415b6e72010::cummies {
    struct CUMMIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUMMIES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"7c800877b19b032549f8b5b394efe114e8e2390dc54abb0232e2c124fcb93902                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CUMMIES>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"cummies     ")))), trim_right(b"CumRocket                       "), trim_right(x"546865206d6f737420696e66616d6f7573206d656d6520636f696e206f662074686520323032312062756c6c72756e206973206261636b2e4120636f696e20736f2077696c6420456c6f6e206163636964656e74616c6c79206c61756e6368656420697420746f20746865206d6f6f6e207769746820612073696e676c6520656d6f6a692074776565742e0a2043554d524f434b45542020746865206f726967696e616c204e53465720646567656e2063756c7475726520746f6b656e2e426f726e2066726f6d206368616f732e204675656c6564206279206d656d65732e20506f7765726564206279207075726520696e7465726e657420737475706964697479202b206e6f7374616c6769612e0a57687920697420776f726b7320616761696e20696e20323032353a204d656d6520686973746f7279203e206e6577206d"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUMMIES>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUMMIES>>(v4);
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

