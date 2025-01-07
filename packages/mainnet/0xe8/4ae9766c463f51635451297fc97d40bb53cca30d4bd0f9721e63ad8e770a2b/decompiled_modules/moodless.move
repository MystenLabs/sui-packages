module 0xe84ae9766c463f51635451297fc97d40bb53cca30d4bd0f9721e63ad8e770a2b::moodless {
    struct MOODLESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODLESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODLESS>(arg0, 6, b"MOODLESS", b"Moodless", b"work in a 100-story building and you work on the 100th floor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_13_184829_0e9777131d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODLESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODLESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

