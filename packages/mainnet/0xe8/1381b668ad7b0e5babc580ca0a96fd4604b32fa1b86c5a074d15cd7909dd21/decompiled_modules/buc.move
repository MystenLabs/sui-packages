module 0xe81381b668ad7b0e5babc580ca0a96fd4604b32fa1b86c5a074d15cd7909dd21::buc {
    struct BUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUC>(arg0, 6, b"BUC", b"buc", b"a deer on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/buc_sui_c9bbc19a7a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUC>>(v1);
    }

    // decompiled from Move bytecode v6
}

