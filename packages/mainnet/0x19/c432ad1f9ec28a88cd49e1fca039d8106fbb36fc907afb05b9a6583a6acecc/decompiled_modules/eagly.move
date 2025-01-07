module 0x19c432ad1f9ec28a88cd49e1fca039d8106fbb36fc907afb05b9a6583a6acecc::eagly {
    struct EAGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: EAGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EAGLY>(arg0, 9, b"EAGLY", b"Sui Eagly", b"Sui Eagly is a meme token symbolizing strength, vision, and loyalty. It represents the soaring potential within the Sui ecosystem, perfect for those looking to rise with the next big super cycle. Combining power with lighthearted community appeal, Sui Eagly is designed to inspire confidence and excitement as it takes flight in the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1812556214485626880/dJBO8MgE.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EAGLY>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EAGLY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EAGLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

