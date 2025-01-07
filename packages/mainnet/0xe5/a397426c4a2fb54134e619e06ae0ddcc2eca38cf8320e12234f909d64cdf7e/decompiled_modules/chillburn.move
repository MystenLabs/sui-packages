module 0xe5a397426c4a2fb54134e619e06ae0ddcc2eca38cf8320e12234f909d64cdf7e::chillburn {
    struct CHILLBURN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLBURN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLBURN>(arg0, 6, b"CHILLBURN", b"Just A Chill Burn", b"In a world where the internet culture reigns supreme, there existed a dog who had become a symbol of universal acceptance of both chaos and serenity. This dog, known as \"This Is Burn Dog\" or simply \"BURN,\" found himself in situations that ranged from the most disastrous to the idyllic, always with the same nonchalant response: \"This is Burn.\" We burning Dollars till 100Millions Market Cap , It will be big BURN !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/67567547_d83d500fb1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLBURN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLBURN>>(v1);
    }

    // decompiled from Move bytecode v6
}

