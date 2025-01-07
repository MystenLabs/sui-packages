module 0xccdd52bfeca56657f09e158aff0fada023bd63791a31eaaf202f26b50e3dbddf::deer {
    struct DEER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEER>(arg0, 6, b"DEER", b"Deer", b"Oh Deer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015734_b768c15025.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEER>>(v1);
    }

    // decompiled from Move bytecode v6
}

