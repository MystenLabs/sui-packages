module 0xa0cea8db7cb0371f6250b5ecf450dfbb740550d8219db7e8142572cc1f5d9a5b::harvey {
    struct HARVEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARVEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARVEY>(arg0, 6, b"HARVEY", b"Harvey The Hedgehog", b"Harvey stayed awake for wintur, just so he can be on SUI, appreciate his effort, by helping him gather some seeds for the winter!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_3_a05452d855.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARVEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARVEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

