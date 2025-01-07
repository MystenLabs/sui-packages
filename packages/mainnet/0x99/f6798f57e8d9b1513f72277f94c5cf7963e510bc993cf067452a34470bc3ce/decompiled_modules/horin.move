module 0x99f6798f57e8d9b1513f72277f94c5cf7963e510bc993cf067452a34470bc3ce::horin {
    struct HORIN has drop {
        dummy_field: bool,
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HORIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<HORIN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: HORIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GjKYDwePfNWMbZHQ1koQ8eXtigkUdCuFmxqr9rCspump.png?size=lg&key=b7a24c                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<HORIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HORIN   ")))), trim_right(b"Horin                           "), trim_right(b"Horin, or Halloween Torin, brings a haunting twist to Tesla's mascot, Torin, by merging it with Halloween's eerie spirit. Imagine Torin dressed in spooky attire with a mix of mystery and charmthink jack-o'-lantern motifs, a dark, enchanted cloak, and a mischievous grin.                                                  "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HORIN>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HORIN>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<HORIN>>(0x2::coin::mint<HORIN>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HORIN>>(v4, 0x2::tx_context::sender(arg1));
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

