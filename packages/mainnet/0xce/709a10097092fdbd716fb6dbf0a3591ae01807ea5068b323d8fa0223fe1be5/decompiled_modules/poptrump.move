module 0xce709a10097092fdbd716fb6dbf0a3591ae01807ea5068b323d8fa0223fe1be5::poptrump {
    struct POPTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPTRUMP>(arg0, 6, b"POPTRUMP", b"PopTrump", x"546865204f6e6c79205472756d70205468617420506f702120506f7021206f6e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_18_08_06_26_f88129bc5b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

