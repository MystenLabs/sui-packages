module 0x4ad37d10d92543fae6746932ab64e5f74f1aca383a1245a5083c768945e356fa::pprt {
    struct PPRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPRT>(arg0, 6, b"PPRT", b"Party Parrot", b"PARTY OR DIE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/60fpsparrot_14963d67a8.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

