module 0xf4d529d89fdd364c5a3c4b83097ea10b42de65c9466591086ece5164907c945c::rug {
    struct RUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUG>(arg0, 6, b"RUG", b"Rugpull", b"The meme depicts Sui's token and a saw, symbolizing the ever-increasing amount of rugpool that is being created daily at movepump. It's not just a meme but a movement of resistance rising from a community that has had enough. Add your brick to building a clean and safe platform by supporting this token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rugpull_8dfe10686e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

