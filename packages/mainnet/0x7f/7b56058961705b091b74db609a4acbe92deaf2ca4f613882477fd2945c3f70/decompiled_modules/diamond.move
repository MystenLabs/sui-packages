module 0x7f7b56058961705b091b74db609a4acbe92deaf2ca4f613882477fd2945c3f70::diamond {
    struct DIAMOND has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIAMOND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIAMOND>(arg0, 6, b"DIAMOND", b"SUI DIAMOND", b"Suik", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avatar_1001534379223_51214e18cb.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIAMOND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIAMOND>>(v1);
    }

    // decompiled from Move bytecode v6
}

