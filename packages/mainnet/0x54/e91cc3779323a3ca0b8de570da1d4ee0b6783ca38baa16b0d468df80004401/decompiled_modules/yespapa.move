module 0x54e91cc3779323a3ca0b8de570da1d4ee0b6783ca38baa16b0d468df80004401::yespapa {
    struct YESPAPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YESPAPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YESPAPA>(arg0, 6, b"Yespapa", b"Cizinu", b"bizarre", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaa_4304568bad.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YESPAPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YESPAPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

