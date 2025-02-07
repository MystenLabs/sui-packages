module 0xf0736f39369fcb59053d3e5a5580759c52771d240cd6637b9c29cee56c545198::farttrump {
    struct FARTTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FrqU6LU6j2qBUcNbLUsv76KCzXxeidhAz2jX4bdyX2vo.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FARTTRUMP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FARTTRUMP   ")))), trim_right(b"FART TRUMP                      "), trim_right(x"466172745472756d702064657374696e656420746f2062652074686520706172746e6572206f662046617274426f792074616b696e67206869732068756d6f7220746f206e657720686569676874732e0a46726f6d207468652073746172742c205472756d70206b6e65772068697320707572706f73652077617320746f206d617463682068697320656e6572677920616e64206d616b65206576657279207072616e6b206576656e2062696767657220616e64206265747465722e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTTRUMP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTTRUMP>>(v4);
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

