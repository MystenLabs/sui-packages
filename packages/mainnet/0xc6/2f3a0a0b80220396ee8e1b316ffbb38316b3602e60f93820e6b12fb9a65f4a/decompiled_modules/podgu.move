module 0xc62f3a0a0b80220396ee8e1b316ffbb38316b3602e60f93820e6b12fb9a65f4a::podgu {
    struct PODGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PODGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PODGU>(arg0, 6, b"Podgu", b"podgu sui", b"podhu sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_27_at_18_63de667f7b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PODGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PODGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

