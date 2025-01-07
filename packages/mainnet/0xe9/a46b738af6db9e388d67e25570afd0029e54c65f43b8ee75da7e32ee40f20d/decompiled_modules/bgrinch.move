module 0xe9a46b738af6db9e388d67e25570afd0029e54c65f43b8ee75da7e32ee40f20d::bgrinch {
    struct BGRINCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGRINCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGRINCH>(arg0, 6, b"BGrinch", b"Blue Grinch", b"The Blue Grinch is a grumpy, Blue creature who lives on an ice mountaintop above the village of Whoville and hates Christmas. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_25_065505_bfb75784e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGRINCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BGRINCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

