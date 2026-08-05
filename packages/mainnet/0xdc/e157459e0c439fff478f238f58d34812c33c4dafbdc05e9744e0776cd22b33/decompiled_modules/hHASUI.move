module 0xdce157459e0c439fff478f238f58d34812c33c4dafbdc05e9744e0776cd22b33::hHASUI {
    struct HHASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHASUI>(arg0, 9, b"hHASUI", b"hHASUI Coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lv-curator.haedal.xyz/Lendvault/lpt/hhasui_4384c4d2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HHASUI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

