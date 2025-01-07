module 0xa9e0d4674576351f90e7559a085b56ce3097aa6421beda845e56a5d9cb7643f::scam {
    struct SCAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAM>(arg0, 6, b"SCAM", b"SUPPER SCAM", b"The coin was created as a SCAM. No X. No Web.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUPPER_SCAM_b09778df6e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

