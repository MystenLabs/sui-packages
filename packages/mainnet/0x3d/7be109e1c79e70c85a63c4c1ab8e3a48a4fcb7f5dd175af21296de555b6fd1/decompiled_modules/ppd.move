module 0x3d7be109e1c79e70c85a63c4c1ab8e3a48a4fcb7f5dd175af21296de555b6fd1::ppd {
    struct PPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPD>(arg0, 6, b"PPD", b"Peter and Pet Dolphin", b"Luis said I cant have a pet dolphin unless I moved to the sea haahaa!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5863_5bf3d94d32.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPD>>(v1);
    }

    // decompiled from Move bytecode v6
}

