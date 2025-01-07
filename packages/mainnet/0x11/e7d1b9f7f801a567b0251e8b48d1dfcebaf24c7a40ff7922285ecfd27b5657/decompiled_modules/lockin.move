module 0x11e7d1b9f7f801a567b0251e8b48d1dfcebaf24c7a40ff7922285ecfd27b5657::lockin {
    struct LOCKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOCKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOCKIN>(arg0, 6, b"LOCKIN", b"LOCK IN", b"Its time to LOCK IN. Everyone's been telling you to lock in for months, if not years at this point. And what did you do today? You probably just sat there at your desk, twiddling your thumbs and thinking of the next play when the real play is right in front of you. You're reading about it right now. it's time to strive for more. Quit watching. More action. History is shaped by those who lock in, and there's no excuse to ever be in the position of being caught off guard. $LOCKIN now, or CLOCK IN later.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_14_at_04_59_44_ab96deb0c0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOCKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

