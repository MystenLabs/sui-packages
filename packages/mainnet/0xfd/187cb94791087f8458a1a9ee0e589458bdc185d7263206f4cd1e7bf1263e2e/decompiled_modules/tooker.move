module 0xfd187cb94791087f8458a1a9ee0e589458bdc185d7263206f4cd1e7bf1263e2e::tooker {
    struct TOOKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOOKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOOKER>(arg0, 6, b"TOOKER", b"Sui Tooker", b"Take Me To The Moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/p8p_SFU_Iu_400x400_1d1489df63.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOOKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOOKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

