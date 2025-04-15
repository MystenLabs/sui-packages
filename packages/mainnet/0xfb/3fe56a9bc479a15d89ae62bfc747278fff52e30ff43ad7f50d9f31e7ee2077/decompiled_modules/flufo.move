module 0xfb3fe56a9bc479a15d89ae62bfc747278fff52e30ff43ad7f50d9f31e7ee2077::flufo {
    struct FLUFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUFO>(arg0, 6, b"FLUFO", b"Flufo", b"i'm $FLUFO , mastermind playing dumb so you don't  see the masterplan.acting bored, moving silent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058399_90127f6705.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

