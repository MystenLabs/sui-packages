module 0xdc3c960c8765c09b8c2ac60a881dad1243213616bf73aa7b44c954cf6c7eec14::sharkety {
    struct SHARKETY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKETY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKETY>(arg0, 6, b"Sharkety", b"SHARKETY ON SUI", b"Swim with the sharks, rise with the tides!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241011_102550_b60c5a06d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKETY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKETY>>(v1);
    }

    // decompiled from Move bytecode v6
}

