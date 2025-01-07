module 0x6ca2c74d76354ba05c236f9ddcacec95c0c0726b300da69ddd1c680e245e7ee7::suimoon {
    struct SUIMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOON>(arg0, 6, b"SUIMOON", b"Suimoon", b"$suimoon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MOODENG_24b7ba9df4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

