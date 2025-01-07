module 0x87008071ba855e8ca5ef93631977ab22171e2ecf06a4496b2aed734a7a710683::lucky {
    struct LUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCKY>(arg0, 6, b"LUCKY", b"Lucky Coin", b"Lucky  is the meme coin that brings good fortune and endless fun to the crypto world!  With a dash of luck and a sprinkle of charm, it's here to make your crypto journey a whole lot brighter.  Whether you're chasing your lucky break  or just in it for the memes, Lucky is the token to keep an eye on!  Let's get lucky and watch those gains roll in!  #LuckyCoin #GoodVibesOnly #CryptoLuck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cvctez0mfj1_ezgif_com_webp_to_jpg_converter_1_8bff1f9ca0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

