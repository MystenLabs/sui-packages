module 0xf6edc9f51787ca7c561923458592bdd1aa852ef595d5beadbb016cef4eda6aa7::mgf {
    struct MGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/ERbdDHhXDRbkLAhva3gHEffHUJmx32hMAVfuwKJDQ3Gi.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MGF>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MGF         ")))), trim_right(b"MAGOFF                          "), trim_right(x"4d41474f4646206973206120646563656e7472616c697a656420687962726964206d656d652063727970746f63757272656e637920746f6b656e2064657369676e656420746f206368616e6e656c207075626c69630a6f70706f736974696f6e20746f20746865204d414741206d6f76656d656e7420696e746f20616e2065636f6e6f6d696320666f7263652c2070726f6d6f74696e672074686520707265736572766174696f6e206f660a416d65726963616e2064656d6f63726163792e204d4746206973206e6f7420616c69676e6564207769746820616e7920706f6c69746963616c2070617274792c206275742073657276657320612073696e67756c617220707572706f73653a0a726573697374696e672074686520696e666c75656e6365206f66204d414741206964656f6c6f677920766961206120646563656e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGF>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MGF>>(v4);
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

