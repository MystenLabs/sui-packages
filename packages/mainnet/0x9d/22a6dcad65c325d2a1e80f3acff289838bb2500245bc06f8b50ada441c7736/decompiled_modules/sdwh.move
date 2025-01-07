module 0x9d22a6dcad65c325d2a1e80f3acff289838bb2500245bc06f8b50ada441c7736::sdwh {
    struct SDWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDWH>(arg0, 6, b"SDWH", b"SuiDogWifHat", b"Why did the hat become blue? Because it's on a fuckin $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suidwh_2d1e3abee2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDWH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDWH>>(v1);
    }

    // decompiled from Move bytecode v6
}

