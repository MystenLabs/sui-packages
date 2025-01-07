module 0x77abeec83f7e41a6b52989147bb3fe172a1f71056ffd271006e5fad454b9bb0::turbo {
    struct TURBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBO>(arg0, 6, b"TURBO", b"Turbo Sui", b"100% community owned", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241006_023712_c643da300b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

