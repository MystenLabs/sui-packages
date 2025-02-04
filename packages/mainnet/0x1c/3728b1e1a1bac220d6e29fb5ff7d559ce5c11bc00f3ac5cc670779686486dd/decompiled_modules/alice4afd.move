module 0x1c3728b1e1a1bac220d6e29fb5ff7d559ce5c11bc00f3ac5cc670779686486dd::alice4afd {
    struct ALICE4AFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALICE4AFD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4AcYXDMsTQvTyAhBjWKP7rYK8eL8mF1iueJNQADtpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ALICE4AFD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Alice4AfD   ")))), trim_right(b"Alice4AfD                       "), trim_right(x"20416c69636534416644202054686520436f6d6d756e6974792054616b656f766572202843544f29206973204c49564521200a0a4765726d616e797320656c656374696f6e7320617265206f6e20466562727561727920323372642c20616e6420456c6f6e2066756c6c7920737570706f72747320746865204166442050617274792e20416c6963652057656964656c2c207468652068656164206f66204166442c206973206174207468652063656e746572206f662074686520706f6c69746963616c2073746f726d616e6420736f206973206f757220746f6b656e212020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALICE4AFD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALICE4AFD>>(v4);
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

