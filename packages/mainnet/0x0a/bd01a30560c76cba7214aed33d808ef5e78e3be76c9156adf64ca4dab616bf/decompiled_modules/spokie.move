module 0xabd01a30560c76cba7214aed33d808ef5e78e3be76c9156adf64ca4dab616bf::spokie {
    struct SPOKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOKIE>(arg0, 6, b"SPOKIE", b"Sui Pokie", b"HI! I'm Sui Pokie $SPOKIE! Best Friend of $LOFI! Join to our adventure and SEND ME!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735904142195.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPOKIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOKIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

