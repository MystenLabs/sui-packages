module 0x8dc433f8bd7a30583177fd1ecaf83886a3ce930336956cc3c3f66486ce6df785::neurosui {
    struct NEUROSUI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NEUROSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NEUROSUI>>(0x2::coin::mint<NEUROSUI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NEUROSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://i.ibb.co/TM5Wr3dt/photo-6120662279423902578-y.jpg                                                                                                                                                                                                                                                                       ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NEUROSUI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NeuroSui")))), trim_right(b"NeuroSui                        "), trim_right(b"NeuroSui is a next-generation AI-powered token built on the high-performance Sui Network. Designed to bridge artificial intelligence with decentralized technology, NeuroSui fuels intelligent agents, data-driven protocols, and smart services across the Sui ecosystem.                                                      "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEUROSUI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NEUROSUI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<NEUROSUI>>(0x2::coin::mint<NEUROSUI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

