module 0x5dba5b675c4fbde0ea51523d4d333713d71e546eda5bd10773a335b66ae6370f::trampygo {
    struct TRAMPYGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAMPYGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRAMPYGO>(arg0, 6, b"TRAMPYGO", b"TRAMPY", b"Hi. I am Trampy  a boot with a hole and I am bit scruffy. Help me to get in shape.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_l1600_3e122f493d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAMPYGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRAMPYGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

