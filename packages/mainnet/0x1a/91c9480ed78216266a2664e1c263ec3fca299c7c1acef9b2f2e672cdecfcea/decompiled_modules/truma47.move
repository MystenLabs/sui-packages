module 0x1a91c9480ed78216266a2664e1c263ec3fca299c7c1acef9b2f2e672cdecfcea::truma47 {
    struct TRUMA47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMA47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMA47>(arg0, 6, b"TrumA47", b"Trump Agent 47", b"New Day has come today we build!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6204_2f77539317.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMA47>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMA47>>(v1);
    }

    // decompiled from Move bytecode v6
}

