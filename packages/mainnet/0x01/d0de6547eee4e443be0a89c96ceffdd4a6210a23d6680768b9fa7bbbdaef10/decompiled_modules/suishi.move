module 0x1d0de6547eee4e443be0a89c96ceffdd4a6210a23d6680768b9fa7bbbdaef10::suishi {
    struct SUISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHI>(arg0, 6, b"SUISHI", b"SUISHI TOKEN", b"Inspired by Sushi food Japan $Suishi is through the crypto market with unparalleled speed and agility, $Suishi represents the force of nature in the world of digital currency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUISHI_f58e817663.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

