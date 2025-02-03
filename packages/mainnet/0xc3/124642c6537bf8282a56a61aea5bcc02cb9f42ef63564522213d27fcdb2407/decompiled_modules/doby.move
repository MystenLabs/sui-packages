module 0xc3124642c6537bf8282a56a61aea5bcc02cb9f42ef63564522213d27fcdb2407::doby {
    struct DOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOBY>(arg0, 6, b"DOBY", b"Doby Frens", b"DOBYfrens are beloved, imaginative, inventive creatures.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_27_15_58_50_93bc531a18.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

