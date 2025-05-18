module 0x58bea003d129a97c408a67a4bcd6bd50c2bbc92663f9d6b58e656a4ae4d179f3::freedurk {
    struct FREEDURK has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FREEDURK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FREEDURK>>(0x2::coin::mint<FREEDURK>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FREEDURK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/qWyxAsagREoNqmxCDh9Nyg53WvX4vKRovtYuFWXpump.png?size=lg&key=7023f3                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FREEDURK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FREEDURK")))), trim_right(b"Free Lil Durk                   "), trim_right(b"FREE DURK. FREE THE VOICE.  He gave the streets a voice, now its time we speak for him.  $FREEDURK  the support coin with a mission. Not just another token. A movement for justice, for one of many, its only another way to express and expose. A community. A fight for justice. FREE Derrick Banks.                         "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FREEDURK>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FREEDURK>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<FREEDURK>>(0x2::coin::mint<FREEDURK>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

