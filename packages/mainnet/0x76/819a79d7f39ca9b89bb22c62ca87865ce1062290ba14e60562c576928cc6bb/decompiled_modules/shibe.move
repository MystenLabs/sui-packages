module 0x76819a79d7f39ca9b89bb22c62ca87865ce1062290ba14e60562c576928cc6bb::shibe {
    struct SHIBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBE>(arg0, 6, b"SHIBE", b"Shibe SUI", b"Prepare for the ultimate meme-coin mashup: Shib and Doge have fused to create the unstoppable duo the crypto world never saw coming! Together, they're rewriting the rules with $SHIBEcombining Doge's charm with Shib's fierce loyalty. Its the best of both worlds, creating a pack that's ready to take over the blockchain. Whether you're team Doge or team Shib, now you can ride the rocket together. To the moon and beyond, because two dogs are better than one!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prop_9c10fcc99e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

