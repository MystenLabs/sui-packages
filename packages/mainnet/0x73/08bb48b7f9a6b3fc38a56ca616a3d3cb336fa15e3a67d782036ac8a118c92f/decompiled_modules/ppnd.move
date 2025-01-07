module 0x7308bb48b7f9a6b3fc38a56ca616a3d3cb336fa15e3a67d782036ac8a118c92f::ppnd {
    struct PPND has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPND>(arg0, 6, b"PPND", b"PUFFY PANDA", b"Soft, cuddly, and deceptively strong. Puffy Panda is the meme king of bamboo forests.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_042922421_74b4749770.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPND>>(v1);
    }

    // decompiled from Move bytecode v6
}

