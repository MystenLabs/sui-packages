module 0xc11f0d8cf82a9d9c42b457ef6165c21b13f1485f436d17d742dd3261a69d7ff4::fed {
    struct FED has drop {
        dummy_field: bool,
    }

    fun init(arg0: FED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FED>(arg0, 9, b"FED", b"Cobin", b"In a Quest to feed every Dog, Master Cobin, a True leader of Dog Memes focused on Dogs Blockchain enhancement and Uniqueness is here to create a better safe space for all $Dogs hereby taking its true position as the leader of $Dogs crypt army. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/40539e0a-99aa-4410-8fe0-786bca0ad48b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FED>>(v1);
    }

    // decompiled from Move bytecode v6
}

