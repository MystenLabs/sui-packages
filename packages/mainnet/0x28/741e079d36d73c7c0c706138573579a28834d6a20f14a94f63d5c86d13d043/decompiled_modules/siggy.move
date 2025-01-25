module 0x28741e079d36d73c7c0c706138573579a28834d6a20f14a94f63d5c86d13d043::siggy {
    struct SIGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIGGY>(arg0, 6, b"SIGGY", b"SIGGY SUI", b"Siggy is a legendary character of VK Fest, and is now one of cryptos most significant cultural icons and mascots. Siggy loves memes! He's kind of a meme himself. Best friends with Spotty and Persik, Siggy is a community based memecoin with one mission: to make memecoins on SUI great again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7951_fe4ea283af.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

