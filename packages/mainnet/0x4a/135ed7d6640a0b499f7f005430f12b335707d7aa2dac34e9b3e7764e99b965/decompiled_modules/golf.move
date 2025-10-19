module 0x4a135ed7d6640a0b499f7f005430f12b335707d7aa2dac34e9b3e7764e99b965::golf {
    struct GOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLF>(arg0, 6, b"Golf", b"Golfzon funs", b"Golfzon fans created a coin to be able to play Golf differently ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1760882900422.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

