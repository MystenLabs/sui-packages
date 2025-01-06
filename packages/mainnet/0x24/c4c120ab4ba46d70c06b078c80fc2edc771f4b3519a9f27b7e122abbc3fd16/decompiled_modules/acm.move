module 0x24c4c120ab4ba46d70c06b078c80fc2edc771f4b3519a9f27b7e122abbc3fd16::acm {
    struct ACM has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ACM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ACM>>(0x2::coin::mint<ACM>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ACM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BM7qSiFCiveaYmmB1ueGCGDXVWvgBivqdDgmxQgupump.png?size=lg&key=c4de94                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ACM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ACM     ")))), trim_right(b"Alicius Muskimus                "), trim_right(b"Elon Musk and Alice Weidel are on a mission to make the world a better place, and Alicius Muskimus is here to lead the charge! The ultimate showdown is expected on January 9, 2025, during the live X talk  but the rocket is already launching, and there's no stopping it now!                                               "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACM>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ACM>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<ACM>>(0x2::coin::mint<ACM>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

