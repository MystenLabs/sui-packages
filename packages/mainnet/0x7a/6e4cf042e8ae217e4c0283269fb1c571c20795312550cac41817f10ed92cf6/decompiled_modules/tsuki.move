module 0x7a6e4cf042e8ae217e4c0283269fb1c571c20795312550cac41817f10ed92cf6::tsuki {
    struct TSUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUKI>(arg0, 6, b"TSUKI", b"Tsuki_SUI", b" $TSUKI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_Hza_ELJW_400x400_641e8ae616.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

