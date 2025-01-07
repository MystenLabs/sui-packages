module 0x96eeafe61a9bf96c04d238983c426199419b04eca7aa033c7fcffeb98befb544::sui2025 {
    struct SUI2025 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI2025, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI2025>(arg0, 6, b"SUI2025", b"Happy New Year", b"Token representing the community's congratulations for the Happy New Year.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/good_night_good_morning_eadb009ae1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI2025>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI2025>>(v1);
    }

    // decompiled from Move bytecode v6
}

