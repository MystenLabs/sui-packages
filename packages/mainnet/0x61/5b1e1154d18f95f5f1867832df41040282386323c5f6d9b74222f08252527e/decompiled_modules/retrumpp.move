module 0x615b1e1154d18f95f5f1867832df41040282386323c5f6d9b74222f08252527e::retrumpp {
    struct RETRUMPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETRUMPP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/84MYW9HcKgj9akdBFJF6mQoA4rL8jAmkLwL6WG67pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RETRUMPP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RETRUMPP    ")))), trim_right(b"RETARDED TRUMPP                 "), trim_right(x"5768656e2063686172747320646f6e277420636861727420616e6420776f72647320646f6e277420776f726420205265746172646564205472756d702072697365732e0a41206d656d6520746f6b656e20666f7267656420696e20636f6e667573696f6e2c20706f776572656420627920636f6e76696374696f6e2c20616e642068656c6420746f6765746865722062792e2e2e2076696265732e20497473206e6f742061626f7574206d616b696e672073656e73652e204974732061626f7574206d616b696e67206e6f6973652e3c62723e57686574686572206865277320706f696e74696e672061742074617269666673206f7220696e76656e74696e67206e657720776f7264732c207468697320746f6b656e2063617074757265732074686174206368616f74696320656e6572677920616e64206c6f636b73206974"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETRUMPP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RETRUMPP>>(v4);
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

