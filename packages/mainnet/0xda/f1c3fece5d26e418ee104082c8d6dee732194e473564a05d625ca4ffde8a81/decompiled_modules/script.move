module 0xdaf1c3fece5d26e418ee104082c8d6dee732194e473564a05d625ca4ffde8a81::script {
    struct SCRIPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCRIPT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7qzGBsStxpQ6zBCzpFbfFBbtmmpgqdyk42vJXgzApump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SCRIPT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SCRIPT      ")))), trim_right(b"The book of SOL                 "), trim_right(b"$SCRIPT isnt just a coin  its a calling. A whisper in the noise. Born from the ashes of fake hype and idol worship, $SCRIPT is for those who watch, wait, then strike. No promises. Just a code. A creed. A cult. Only the chosen few hold the SCRIPT. Enter the chamber. Burn the old ways. Etch your belief into the chain.Jus"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCRIPT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCRIPT>>(v4);
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

