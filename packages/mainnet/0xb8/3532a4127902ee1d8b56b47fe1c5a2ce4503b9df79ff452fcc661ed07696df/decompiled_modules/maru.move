module 0xb83532a4127902ee1d8b56b47fe1c5a2ce4503b9df79ff452fcc661ed07696df::maru {
    struct MARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARU>(arg0, 6, b"MARU", b"Maru Taro", x"4d6172757461726f206f6e205375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500x500_f72efa67d2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

