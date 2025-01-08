module 0x56cf57c0d0ec58bf455f83f7944ce04c6a054f85eb10de56b218992908c52122::lunlun {
    struct LUNLUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUNLUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUNLUN>(arg0, 6, b"LUNLUN", b"Sui Lunlun", b"Meet lunlun punyama, he's an avarage town, he wants to win a nobel  prize and save the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022087_f68f846e89.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUNLUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUNLUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

