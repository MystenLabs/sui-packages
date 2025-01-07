module 0x6a6456b6874df8a4f7d5f5696307ed7c550e1737f754a2910cb95676bd4ffe1c::fiw {
    struct FIW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIW>(arg0, 6, b"FIW", b"777FIWSUI", b"FIW ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4658_e2385c7bb6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIW>>(v1);
    }

    // decompiled from Move bytecode v6
}

