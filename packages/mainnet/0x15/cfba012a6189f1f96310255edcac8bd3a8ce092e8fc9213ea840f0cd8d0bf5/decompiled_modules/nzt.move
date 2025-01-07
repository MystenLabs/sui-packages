module 0x15cfba012a6189f1f96310255edcac8bd3a8ce092e8fc9213ea840f0cd8d0bf5::nzt {
    struct NZT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NZT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NZT>(arg0, 6, b"NZT", b"NZT-48", b"The film follows Edward Morra, a struggling writer who is introduced to a drug called NZT-48, which gives him the ability to use his brain fully which helps him vastly improve his lifestyle. Limitless was released on March 18, 2011.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732360607987.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NZT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NZT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

