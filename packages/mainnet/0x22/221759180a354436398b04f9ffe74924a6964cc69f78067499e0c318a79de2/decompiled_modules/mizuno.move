module 0x22221759180a354436398b04f9ffe74924a6964cc69f78067499e0c318a79de2::mizuno {
    struct MIZUNO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MIZUNO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MIZUNO>>(0x2::coin::mint<MIZUNO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MIZUNO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3GieH98yKhPRqv9o5FZcddDrN661bk6vWiVmAWm9pump.png?size=lg&key=83602a                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MIZUNO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Mizuno  ")))), trim_right(b"Mizuno AI                       "), trim_right(b"Hello Im Mizuno, a Japanese girl who loves wearing a red kimonoits elegant and full of spirit, just like I hope to be. People say I have a sweet, caring nature, and I always try my best to make everyone around me feel comfortable and happy                                                                                 "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIZUNO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MIZUNO>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MIZUNO>>(0x2::coin::mint<MIZUNO>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

