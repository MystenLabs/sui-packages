module 0xe09f3a41a89310e4e6f9178629f278370504838a9b464b9254f4dce236d4e62f::doggo {
    struct DOGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EHKwhV1eS7GttxxwLe8UaoaFGn7fga251oyc4ssJpump.png?claimId=c2KI17NPr7dD3Fee                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DOGGO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Doggo       ")))), trim_right(b"First BTC Encrypted Dog         "), trim_right(x"54686973207761736e2774206a75737420616e6f74686572206d656d653b2069742077617320656d62656464656420776974682074686520444e41206f66206120646f672c20656e6372797074656420696e746f2074686520626c6f636b636861696e2e204275742077617320666f72676f7474656e2c207468656e20726563656e746c7920612067726f7570206f6620446567656e65726174657320666f756e642068696d206166746572203134207972732e200a0a446f6e277420626f746865722061736b696e67207768657265207265746172642c206974277320656e637279707465642e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGGO>>(v4);
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

