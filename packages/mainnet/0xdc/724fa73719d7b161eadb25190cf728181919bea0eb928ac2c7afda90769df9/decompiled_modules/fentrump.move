module 0xdc724fa73719d7b161eadb25190cf728181919bea0eb928ac2c7afda90769df9::fentrump {
    struct FENTRUMP has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FENTRUMP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FENTRUMP>>(0x2::coin::mint<FENTRUMP>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FENTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/c7dc25629d8bf2399ef962a6d24fa82b422e9b2f11a7d6b830698f063eeff8e9?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FENTRUMP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FENTRUMP")))), trim_right(b"OFFICIAL FENT TRUMP             "), trim_right(b"Trump signed an executive order to classify illicit fentanyl as weapon of mass destruction. Donating creator fees to fent addicts. This is the Official Fent Trump.                                                                                                                                                             "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FENTRUMP>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FENTRUMP>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<FENTRUMP>>(0x2::coin::mint<FENTRUMP>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

