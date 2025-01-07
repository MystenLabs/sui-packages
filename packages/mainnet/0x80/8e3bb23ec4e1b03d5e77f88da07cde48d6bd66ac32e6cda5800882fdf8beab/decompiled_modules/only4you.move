module 0x808e3bb23ec4e1b03d5e77f88da07cde48d6bd66ac32e6cda5800882fdf8beab::only4you {
    struct ONLY4YOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONLY4YOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONLY4YOU>(arg0, 9, b"ONLY4YOU", b"OnlyForYou", b"Looking for a romantic gesture? OnlyForYou is the perfect way to express your love and appreciation. Gift this token to your special someone and let them know they're the only one for you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/08c4e6d8-5262-42b1-8aa2-808ddac8db92.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONLY4YOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONLY4YOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

