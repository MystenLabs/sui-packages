module 0x525438d7e677afc5af3f9c4398f0507996fa03e8e8e70b84eb88a9ac46d9d739::xdiamond {
    struct XDIAMOND has drop {
        dummy_field: bool,
    }

    fun init(arg0: XDIAMOND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7FkTx17nV14XmDjN427ApPWKzZuR9QbU4mJwRU1Rpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<XDIAMOND>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"XDiamond    ")))), trim_right(b"X Diamond                       "), trim_right(x"58204469616d6f6e642028584469616d6f6e64290a5468652058204469616d6f6e64206d656d6520636f696e20697320612063727970746f63757272656e637920696e73706972656420627920224469616d6f6e642048616e6473222c207768696368207369676e696669657320686f6c64696e67206f6e746f20616e2061737365742064657370697465206d61726b657420766f6c6174696c6974792e2054686973207465726d206761696e656420706f70756c6172697479205768656e20696e766573746f72732068656c64206f6e746f20746865697220706f736974696f6e732064657370697465207369676e69666963616e742070726963652064726f70732e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XDIAMOND>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XDIAMOND>>(v4);
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

