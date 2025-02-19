module 0x99599ed60fee8644cb44fc3a0f41b8f47801d0b6e2102c08bebe5fe1a939d13f::wiz {
    struct WIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"https://gateway.pinata.cloud/ipfs/bafybeicyop2tqgs72ehcljx2qq4rv7l3ahhaw2f4qlbjynmv5qu52r65gy                                                                                                                                                                                                                                   ");
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<WIZ>(arg0, 9, 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WIZ     ")))), trim_right(b"CryptoWiz Coin                  "), trim_right(b"Coin powers the CryptoWiz AI ecosystem rewarding users for engagement predictions and participation in the crypto community The token fuels automated market analysis interaction and social rewards for loyal followers                                                                                                        "), v1, arg1);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<WIZ>>(0x2::coin::mint<WIZ>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WIZ>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIZ>>(v3);
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

