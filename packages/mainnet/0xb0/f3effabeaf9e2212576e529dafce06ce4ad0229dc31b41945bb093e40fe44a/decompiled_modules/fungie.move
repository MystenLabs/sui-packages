module 0xb0f3effabeaf9e2212576e529dafce06ce4ad0229dc31b41945bb093e40fe44a::fungie {
    struct FUNGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNGIE>(arg0, 6, b"FUNGIE", b"Fungie", b"Guinness record dolphin spreading good vibes on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_06_at_8_47_50_PM_dabfbf6ac4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUNGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

