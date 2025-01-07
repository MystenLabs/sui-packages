module 0x7304d1a620bfba830c33bfc378a117c63e1cc013b302108b5c53c0b44b32f78f::trooperdog {
    struct TROOPERDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROOPERDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROOPERDOG>(arg0, 6, b"TROOPERDOG", b"TROOPER", b"A HERO DOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snipaste_2024_10_13_00_00_05_f1c773c173.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROOPERDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROOPERDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

