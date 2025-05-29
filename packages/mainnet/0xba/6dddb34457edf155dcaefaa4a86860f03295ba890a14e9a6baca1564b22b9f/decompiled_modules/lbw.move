module 0xba6dddb34457edf155dcaefaa4a86860f03295ba890a14e9a6baca1564b22b9f::lbw {
    struct LBW has drop {
        dummy_field: bool,
    }

    fun init(arg0: LBW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LBW>(arg0, 9, b"LBW", b"Lootborn Warriors", b"An upcoming game set to take the world by storm! 'Dark Heroes: Chest Grinder,' a mobile game, will soon be available for download on the Google Play Store and Apple App Store.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1409e40bc54284a2402d776d8100f9d5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LBW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LBW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

