module 0x9d9e397cd5b02f7900e6b51526e69abafabc2afa98d9e70e324fb982c3a01e2a::broccoli {
    struct BROCCOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROCCOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROCCOLI>(arg0, 6, b"Broccoli", b"Broccoli's Story", b"A year and a half ago, I casually chatted with a friend who owned a (real) zoo in Dubai. Curious, I asked what dog breed is adapted to the Dubai summer heat. I had no plans to get a dog. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739468646515.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BROCCOLI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROCCOLI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

