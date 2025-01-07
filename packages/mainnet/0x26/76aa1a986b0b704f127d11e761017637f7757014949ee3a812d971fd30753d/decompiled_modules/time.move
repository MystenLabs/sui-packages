module 0x2676aa1a986b0b704f127d11e761017637f7757014949ee3a812d971fd30753d::time {
    struct TIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIME>(arg0, 6, b"TIME", b"ITSTIME", b"A Quirky Fusion of Pixels and Penguinity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/itstime_3e744b0978.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

