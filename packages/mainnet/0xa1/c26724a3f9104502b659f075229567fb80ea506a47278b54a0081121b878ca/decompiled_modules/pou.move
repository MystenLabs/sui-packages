module 0xa1c26724a3f9104502b659f075229567fb80ea506a47278b54a0081121b878ca::pou {
    struct POU has drop {
        dummy_field: bool,
    }

    fun init(arg0: POU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POU>(arg0, 6, b"POU", b"Pou", b"Pou on Sui. Do u even care? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4261_40b375a213.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POU>>(v1);
    }

    // decompiled from Move bytecode v6
}

