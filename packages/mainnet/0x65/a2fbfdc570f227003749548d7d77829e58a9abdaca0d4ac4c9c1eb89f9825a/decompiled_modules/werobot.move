module 0x65a2fbfdc570f227003749548d7d77829e58a9abdaca0d4ac4c9c1eb89f9825a::werobot {
    struct WEROBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEROBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEROBOT>(arg0, 6, b"WEROBOT", b"WE.ROBOT", b"Elon X profile change: Profile Image", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d_JOF_7o_B_400x400_217f69a74f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEROBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEROBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

