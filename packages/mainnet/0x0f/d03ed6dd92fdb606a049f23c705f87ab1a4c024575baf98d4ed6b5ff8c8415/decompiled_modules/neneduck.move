module 0xfd03ed6dd92fdb606a049f23c705f87ab1a4c024575baf98d4ed6b5ff8c8415::neneduck {
    struct NENEDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NENEDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NENEDUCK>(arg0, 6, b"NENEDUCK", b"NENE DUCK SUI", x"4e454e45204455434b20244e454e454455434b20697320746865206375746573740a616e642066756e6e69657374206d656d65636f696e206f6e2074686520535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GQ_Doi0pb_EA_Umc_R_e36b63ff68.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NENEDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NENEDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

