module 0xbd999f0de2db21ad6a7d68afe0c52f62458a55610ecbefaa6f8348a7ea1e4c59::scarlo {
    struct SCARLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCARLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCARLO>(arg0, 6, b"SCARLO", b"SUICARLO", b"A dog with pink a**hole. Previously REDACTED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u246_H9_HN_400x400_08ebc766fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCARLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCARLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

