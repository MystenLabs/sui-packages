module 0x5db047dcbbc52327108bd3626cd654a5553b5fbc9eb599a97acb091dec67d90a::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAT>(arg0, 6, b"SUICAT", b"NYAN SUICAT", b"Suiyan Cat is a playful, water-space flying creature with a Sui Pop-Tart torso, inspired by the iconic Nyan Cat. It zooms through a surreal blend of underwater and cosmic landscapes, leaving a vibrant, bullish rainbow trail behind it, symbolizing optimism and excitement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_68f9726dc8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

