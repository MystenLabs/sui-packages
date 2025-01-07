module 0x16dee76cce4dfdf9a8ae5ffad880e6ab233a5cdd8242bb75a46137dac0ddc1ff::mm {
    struct MM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MM>(arg0, 6, b"MM", b"Maracas Man", b"Maracas Man is always around to shake things up! Those hips don't lie. Let's take this meme to the moon (or Mars).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_22_at_11_31_34_AM_3273abe2ca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MM>>(v1);
    }

    // decompiled from Move bytecode v6
}

