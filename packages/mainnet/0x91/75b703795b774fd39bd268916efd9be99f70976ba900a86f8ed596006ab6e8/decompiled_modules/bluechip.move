module 0x9175b703795b774fd39bd268916efd9be99f70976ba900a86f8ed596006ab6e8::bluechip {
    struct BLUECHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUECHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUECHIP>(arg0, 6, b"BLUECHIP", b"POTATO BLUECHIP", b"A blue potato mfer stands alone as the sole blue-chip memecoin on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3633_f7423e80c4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUECHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUECHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

