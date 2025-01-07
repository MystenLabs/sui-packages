module 0x645013b8d54d7c9bd2410cefebf334f48e7c460ed072baa13961c7d9561cea89::oocat {
    struct OOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OOCAT>(arg0, 9, b"OOCAT", x"d09e5fd0be", b"Another meme cat, from my personal archive, you haven't seen this one yet))))))", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2006c1f9-d28d-430d-a838-55af2bf478f3-IMG_20241004_182906_900.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

