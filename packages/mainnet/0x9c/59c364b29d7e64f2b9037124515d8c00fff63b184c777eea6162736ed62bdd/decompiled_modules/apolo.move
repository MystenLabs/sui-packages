module 0x9c59c364b29d7e64f2b9037124515d8c00fff63b184c777eea6162736ed62bdd::apolo {
    struct APOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: APOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APOLO>(arg0, 6, b"APOLO", b"Apolo", b"Apolo is the most brutal on Sui. Fish are afraid of HIM, because he literally kills them in seconds.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731006915211.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APOLO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APOLO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

