module 0x69bc1de9829af45db43609017a4a489da62919788b4710be1f28606105e311c4::boncatsui {
    struct BONCATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONCATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONCATSUI>(arg0, 6, b"BONCATSUI", b"BONCAT", b"BONCAT ON SUI ANIME POPOPOP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/989a371c2cd649f258e393500d854984_1716193659_cf81a37a68.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONCATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONCATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

