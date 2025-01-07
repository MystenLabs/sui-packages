module 0x74d07b9258a68faa7df58f049d0f5f8b06b18806726499d46d4387ff6694319f::slot {
    struct SLOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOT>(arg0, 6, b"SLOT", b"Slay Otter", b"A natural at turning opportunities into slay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a68f9e273e475471a5822072644d8231_86acc399ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

