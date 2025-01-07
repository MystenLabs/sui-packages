module 0xbc0804c089e16d70e57b6242d82d22a3412255d484d7a113278f7137ede53ab1::hopdick {
    struct HOPDICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPDICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPDICK>(arg0, 6, b"HOPDICK", b"HOP DICK", b"HOP AND DICK ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suick_1_9f1f966ee6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPDICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPDICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

