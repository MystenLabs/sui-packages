module 0xae918aba36e331a4bd53547511bca033af0169f05ee583b25bd344dff18d3d9e::una {
    struct UNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BbsgkH6mfKH8f7Z354vxY91hHV6zQzjnzx7SoM5tpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<UNA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"UNA         ")))), trim_right(b"Unlimit AI                      "), trim_right(b"A platform for creating AI agents in a couple of clicks. Use agents on our website, in telegram bots or integrate them into your website via API. AI agents are just the beginning. AI artists can post their unique models and earn $UNA tokens. Tired of rugs and jets? Create AI agents or characters and launch tokens on ou"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNA>>(v4);
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

