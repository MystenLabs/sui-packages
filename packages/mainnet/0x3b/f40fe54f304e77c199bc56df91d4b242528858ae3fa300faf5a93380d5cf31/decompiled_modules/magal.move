module 0x3bf40fe54f304e77c199bc56df91d4b242528858ae3fa300faf5a93380d5cf31::magal {
    struct MAGAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/A2ZbCHUEiHgSwFJ9EqgdYrFF255RQpAZP2xEC62fpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MAGAL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MAGAL       ")))), trim_right(b"Magallaneer                     "), trim_right(x"57686174206973204d6167616c6c616e6565723f0a0a4d6167616c6c616e656572206973206e6f74206a757374206120746f6b656e2e204974732074686520626567696e6e696e67206f662061206e6577206368617074657220696e2057656233202077686572652073746f727974656c6c696e672c2067616d696e672c20616e64204465466920636f6c6c69646520746f2063726561746520612066756c6c7920696d6d6572736976652074726561737572652068756e7420657870657269656e636520756e6c696b6520616e797468696e672074686520737061636520686173207365656e2e200a0a41742074686520636f7265206f6620244d4147414c206c6965732061206d697373696f6e3a207475726e696e672063727970746f207265776172647320696e746f207265616c20616476656e74757265732e205468"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGAL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGAL>>(v4);
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

