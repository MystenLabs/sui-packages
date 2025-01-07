module 0x1327335d6cf360dd1ceb72c35c982856efe5af1259f94b6621d7a2e33982a518::wcat {
    struct WCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCAT>(arg0, 6, b"WCAT", b"White CAT", b"white cat meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/meob_6344ba3a84.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

