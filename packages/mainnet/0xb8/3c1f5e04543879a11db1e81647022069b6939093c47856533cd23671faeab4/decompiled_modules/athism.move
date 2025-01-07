module 0xb83c1f5e04543879a11db1e81647022069b6939093c47856533cd23671faeab4::athism {
    struct ATHISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATHISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATHISM>(arg0, 6, b"ATHism", b"Autistic Dolphin", b"Autistic dolphin that thinks it's spelled ATHism. Oh wait look at that we Sui at ATH! DjdKjJJJ$sjsjk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AT_Hismm_d07ceec402.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATHISM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATHISM>>(v1);
    }

    // decompiled from Move bytecode v6
}

