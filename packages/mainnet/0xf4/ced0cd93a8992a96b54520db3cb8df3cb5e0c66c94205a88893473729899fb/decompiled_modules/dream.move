module 0xf4ced0cd93a8992a96b54520db3cb8df3cb5e0c66c94205a88893473729899fb::dream {
    struct DREAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DREAM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/B9zze29or7CJs1nBrigSCWSibfxvkmieFXcGg5cxbonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DREAM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DREAM       ")))), trim_right(b"Dreamsync                       "), trim_right(x"447265616d73796e632069732061206d756c7469666163657465642070726f6a656374207468617420636f6d62696e65732063727970746f63757272656e63792c20504f562028706f696e742d6f662d766965772920636f6e74656e74206372656174696f6e2c20616e6420636f6d6d756e69747920656e676167656d656e742e204974207265766f6c7665732061726f756e642024445245414d2c20612063727970746f63757272656e637920746861742066756e64732061207765656b6c79206368616c6c656e67652065636f73797374656d20616e642069732064657369676e656420746f2067726f7720696e746f2061206c61726765722073747265616d696e6720706c6174666f726d2e0a0a4576657279204d6f6e6461792c20776520646f6e61746520312c3030302c3030302024445245414d20646972656374"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DREAM>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DREAM>>(v4);
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

