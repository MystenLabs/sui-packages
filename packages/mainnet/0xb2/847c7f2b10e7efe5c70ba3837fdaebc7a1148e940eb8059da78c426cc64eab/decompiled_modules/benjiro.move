module 0xb2847c7f2b10e7efe5c70ba3837fdaebc7a1148e940eb8059da78c426cc64eab::benjiro {
    struct BENJIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENJIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENJIRO>(arg0, 6, b"BENJIRO", b"BenjiSui", b"Benjiro On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Benjiro_665e64d2b9.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENJIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENJIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

