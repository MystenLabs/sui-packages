module 0x62ccd8aec11955f3a727a6b7c34d76327460d3b83e250694a27da7186b37635b::pepesui {
    struct PEPESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPESUI>(arg0, 6, b"PEPESUI", b"SUIPEPE", b"a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_006de656b8.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

