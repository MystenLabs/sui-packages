module 0x4ca009cd3fe538b9a3fcd4ae0427063819f57101dcb92498d40a5bb4a025c13f::maccin {
    struct MACCIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MACCIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MACCIN>(arg0, 6, b"MACCIN", b"Shift Leader", b"Welcome, Im your shift leader. Now go drop some fries nigga. Im tired of these Burger king eating ass A.Is. Send this shit or meet me in the parking lot. Whats MACCIN?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7265_49d35d05d8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MACCIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MACCIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

