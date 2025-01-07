module 0xc3cb6a7dae8a7f240f01e71e29e368bd613306ef6437c39c83254eecb83072fc::axel {
    struct AXEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXEL>(arg0, 6, b"AXEL", b"AXEL ON SUI", x"6178656c2c20746865206d61696e6c69676874206f66207375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sf1_Fmyy_J_400x400_f8c03caeab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

