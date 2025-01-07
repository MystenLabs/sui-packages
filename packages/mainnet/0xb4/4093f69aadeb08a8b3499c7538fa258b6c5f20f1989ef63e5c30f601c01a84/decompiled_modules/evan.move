module 0xb44093f69aadeb08a8b3499c7538fa258b6c5f20f1989ef63e5c30f601c01a84::evan {
    struct EVAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVAN>(arg0, 6, b"$EVAN", b"EVAN CHENG", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://evanonsui.com/wp-content/uploads/2024/10/cropped-logo-192x192.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVAN>>(v1);
        0x2::coin::mint_and_transfer<EVAN>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

