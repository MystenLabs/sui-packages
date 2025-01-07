module 0xa9113eec4f1ea5ab6799493e7dc6e5364f7d1796f859412853bbe0c6e2156454::lautngab {
    struct LAUTNGAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUTNGAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAUTNGAB>(arg0, 9, b"LAUTNGAB", b"Lautngab", b"Lautngab ini", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9fd12743-1108-448f-882b-ad479a2f42db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAUTNGAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAUTNGAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

