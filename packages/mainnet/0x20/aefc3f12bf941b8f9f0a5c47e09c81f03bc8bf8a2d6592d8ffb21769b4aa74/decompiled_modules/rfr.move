module 0x20aefc3f12bf941b8f9f0a5c47e09c81f03bc8bf8a2d6592d8ffb21769b4aa74::rfr {
    struct RFR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RFR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RFR>(arg0, 9, b"RFR", b"ReefRumble", b"ReefRumble is a vibrant meme coin designed to celebrate the beauty and diversity of coral reefs while fostering a sense of community and environmental responsibility. With its playful mascot, a cheeky reef fish, ReefRumble aims to engage users in both fun and meaningful ways.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRACIccV7OYUFL8SE1q4j3arAINaW6JBv6VhA&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RFR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RFR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RFR>>(v1);
    }

    // decompiled from Move bytecode v6
}

