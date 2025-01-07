module 0x4eeb51233671852205eee165a84ad612b10f91e9d3c9e28e438c7e809b34f3f0::nall {
    struct NALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NALL>(arg0, 6, b"NALL", b"All or Nothing", b"All or Nothing.   We going to make it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIG_2_c3c855f437.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

