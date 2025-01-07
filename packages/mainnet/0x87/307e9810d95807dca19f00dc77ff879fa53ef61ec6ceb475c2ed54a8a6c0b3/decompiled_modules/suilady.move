module 0x87307e9810d95807dca19f00dc77ff879fa53ef61ec6ceb475c2ed54a8a6c0b3::suilady {
    struct SUILADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILADY>(arg0, 6, b"SUILADY", b"Mysuilady", b"SIULADY is just a new collection on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Proyecto_nuevo_48_bb09b26b09_36d204a9ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILADY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILADY>>(v1);
    }

    // decompiled from Move bytecode v6
}

