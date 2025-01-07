module 0x68300a7d00e2d95dad0a9201bb62e30252195cf71bf0fbbe744f4f2f589337f3::jipy {
    struct JIPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIPY>(arg0, 6, b"JIPY", b"Sui Jipy", b"Sui Jipy likes spilling the tea with his lil friends", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_09_16_T201445_674_3cac90e593.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JIPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

