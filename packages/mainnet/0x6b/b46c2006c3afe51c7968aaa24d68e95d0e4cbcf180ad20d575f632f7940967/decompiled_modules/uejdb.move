module 0x6bb46c2006c3afe51c7968aaa24d68e95d0e4cbcf180ad20d575f632f7940967::uejdb {
    struct UEJDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: UEJDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UEJDB>(arg0, 9, b"UEJDB", b"hdjd", b"fjnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c6a6289-5d0f-41c8-8ee9-3ec98f570d83.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UEJDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UEJDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

