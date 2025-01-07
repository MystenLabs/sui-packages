module 0xf5db5b998d51d64fa7f515b359cf3e257f4290f9be1b030a3f21f4eb3de2deca::lfgo {
    struct LFGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LFGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LFGO>(arg0, 6, b"LFGO", b"LFGO!", b"LETSFUCKINGO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_09_163910_4e4e5e3ffb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LFGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LFGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

