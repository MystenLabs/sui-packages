module 0x4dc74151210426c956bf87fa8aed00689bc8bd70acffd7f146f0116a492fa614::spl0 {
    struct SPL0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPL0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPL0>(arg0, 6, b"SPL0", b"SPLO CTO", b"SPLO CTO | ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/splo_back_27881f09d9.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPL0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPL0>>(v1);
    }

    // decompiled from Move bytecode v6
}

