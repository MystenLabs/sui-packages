module 0x5b32552b4237547a597dae204586b28586543c694de1dfc551eba0de7b6110a::Run {
    struct RUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUN>(arg0, 9, b"RUN", b"Run", b"faster than all memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GyuW0bIXwAArW3c?format=jpg&name=large")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

