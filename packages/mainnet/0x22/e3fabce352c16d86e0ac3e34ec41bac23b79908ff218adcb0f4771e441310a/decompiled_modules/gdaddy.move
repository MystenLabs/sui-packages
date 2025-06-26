module 0x22e3fabce352c16d86e0ac3e34ec41bac23b79908ff218adcb0f4771e441310a::gdaddy {
    struct GDADDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDADDY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2pZEsnE1ZX4Q6ggycWWzKQExpCx1rRyxhzCyvvR4pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GDADDY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GDADDY      ")))), trim_right(b"Green Daddy                     "), trim_right(x"496e2074686520626567696e6e696e672c2074696d656c696e6573207765726520656d70747920616e6420706978656c73207765726520706c61696e2e205468656e20656d657267656420477265656e2044616464792c207772617070656420696e206869732069636f6e696320677265656e206d6f727068737569742c20626f726e20746f2062652065646974656420696e746f2065766572797468696e6720616e6420657665727977686572652e0a0a486520686173206e6f20666163652c206e6f206c696d6974732e204f6e65206d6f6d656e7420686573207374657070696e67206f666620612070726976617465206a65742c20746865206e6578742068657320696e20796f7572206772616e646d617320766972616c20666f72776172642e2054686520696e7465726e6574206973206869732063616e7661732e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDADDY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GDADDY>>(v4);
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

