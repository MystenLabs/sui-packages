module 0x6f720bda55ddc0c1e919e018cd16b3a6196482d50aec651b1690ee42c024b30a::comm {
    struct COMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMM>(arg0, 6, b"Comm", b"Comm Token", b"Official Community backed SUI Network token!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734234359935.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COMM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

