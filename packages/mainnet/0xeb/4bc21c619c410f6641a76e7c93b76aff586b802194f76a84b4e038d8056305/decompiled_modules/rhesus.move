module 0xeb4bc21c619c410f6641a76e7c93b76aff586b802194f76a84b4e038d8056305::rhesus {
    struct RHESUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHESUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHESUS>(arg0, 6, b"RHESUS", b"Rhesus Monkeys", b"We are the monkeys that escaped the experimental lab Alpha Genesis.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731003018652.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RHESUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHESUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

