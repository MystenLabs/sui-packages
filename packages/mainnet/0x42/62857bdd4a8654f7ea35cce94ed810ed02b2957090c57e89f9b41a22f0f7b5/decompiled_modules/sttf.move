module 0x4262857bdd4a8654f7ea35cce94ed810ed02b2957090c57e89f9b41a22f0f7b5::sttf {
    struct STTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: STTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STTF>(arg0, 6, b"STTF", b"SUIToTheFuture", b"Sui To The Future !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_e8ec516c36.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STTF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STTF>>(v1);
    }

    // decompiled from Move bytecode v6
}

