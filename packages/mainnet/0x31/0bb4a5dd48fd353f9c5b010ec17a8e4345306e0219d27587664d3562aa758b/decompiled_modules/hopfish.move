module 0x310bb4a5dd48fd353f9c5b010ec17a8e4345306e0219d27587664d3562aa758b::hopfish {
    struct HOPFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPFISH>(arg0, 6, b"HOPFISH", b"HopFish", b"They say fish don't jump, I'm an exception #sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_8_E4lh_400x400_9f350872c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

