module 0x7bfb51071e1b6af56891fda2c2961f8e2af20145a16fa6230d622605267f6c34::kumo {
    struct KUMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUMO>(arg0, 6, b"KUMO", b"Kumo The Cat", b"A clumsy cat has entered the chat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730960807567.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUMO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

