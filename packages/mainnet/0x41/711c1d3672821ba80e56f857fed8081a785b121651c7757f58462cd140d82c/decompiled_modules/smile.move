module 0x41711c1d3672821ba80e56f857fed8081a785b121651c7757f58462cd140d82c::smile {
    struct SMILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMILE>(arg0, 6, b"SMILE", b"The Web is Watching", b"$SMILE The Web Is Watching - Your Privacy Is An Illusion.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733387686044.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMILE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMILE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

