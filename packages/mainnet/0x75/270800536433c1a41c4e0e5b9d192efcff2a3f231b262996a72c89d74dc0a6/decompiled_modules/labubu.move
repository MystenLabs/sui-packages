module 0x75270800536433c1a41c4e0e5b9d192efcff2a3f231b262996a72c89d74dc0a6::labubu {
    struct LABUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABUBU>(arg0, 6, b"Labubu", b"labubu", b"labubu test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1751944117299.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LABUBU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABUBU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

