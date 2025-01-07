module 0x4c919b4c5deae39fa3acdd6d80d8ff7576e6da989a3a52f6b9ea599764aa63e0::bullpluss {
    struct BULLPLUSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLPLUSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLPLUSS>(arg0, 6, b"BullPluss", b"BULL PLUS 1", b"BULL PLUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Bull_74e06a039b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLPLUSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLPLUSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

