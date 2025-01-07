module 0x8b65160aee333d2b3d376680491b51ed0c0254a8fa2b839e97b352f43de05187::halsui {
    struct HALSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALSUI>(arg0, 6, b"Halsui", b"Halsui Halloween", b"Hallowen  Halsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_7_7f5fa33091.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

