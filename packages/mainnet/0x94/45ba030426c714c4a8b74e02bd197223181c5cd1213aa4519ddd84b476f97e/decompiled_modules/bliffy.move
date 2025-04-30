module 0x9445ba030426c714c4a8b74e02bd197223181c5cd1213aa4519ddd84b476f97e::bliffy {
    struct BLIFFY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BLIFFY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BLIFFY>>(0x2::coin::mint<BLIFFY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BLIFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x2c3fb68f9c5f1e2debf1e9a85bd4c75af078e4c2.png?size=lg&key=717ab3                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BLIFFY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BLIFFY  ")))), trim_right(b"Bliffy AI                       "), trim_right(b"Bliffy is an amnesiac robot lost in PUMPOPOLIS, stranded far from his true destination: Bitcoin.  He was destined for greatness, but something-or someone-derailed his journey.  Can he unlock his lost memories and find his way back? Its up to you to join the mission, uncover the mystery and guide Bliffy home.           "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLIFFY>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BLIFFY>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<BLIFFY>>(0x2::coin::mint<BLIFFY>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

