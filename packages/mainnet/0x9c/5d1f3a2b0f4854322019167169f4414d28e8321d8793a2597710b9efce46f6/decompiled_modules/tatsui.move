module 0x9c5d1f3a2b0f4854322019167169f4414d28e8321d8793a2597710b9efce46f6::tatsui {
    struct TATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TATSUI>(arg0, 6, b"TATSUI", b"ANDREI TATSUI", b"send it. I know. We know. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_04_18_02_56_925b4ef213.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

