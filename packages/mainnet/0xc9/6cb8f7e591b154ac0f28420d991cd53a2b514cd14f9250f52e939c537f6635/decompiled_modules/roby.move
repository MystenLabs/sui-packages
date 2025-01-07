module 0xc96cb8f7e591b154ac0f28420d991cd53a2b514cd14f9250f52e939c537f6635::roby {
    struct ROBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBY>(arg0, 6, b"ROBY", b"Roby", b"Wait! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7163_1ad93e535d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

