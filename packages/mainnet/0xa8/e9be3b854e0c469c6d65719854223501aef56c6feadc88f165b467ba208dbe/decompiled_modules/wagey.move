module 0xa8e9be3b854e0c469c6d65719854223501aef56c6feadc88f165b467ba208dbe::wagey {
    struct WAGEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAGEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAGEY>(arg0, 6, b"WAGEY", b"WAGEY ON SUI", b"Wagey on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b_G2q_z_Md_400x400_f33b1c6890.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAGEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAGEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

