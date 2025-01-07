module 0x3c69a4e4f80e803141e63a9b58844bda02f15ab3d17f13de802586c705045a21::todo {
    struct TODO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TODO>(arg0, 9, b"TODO", b"TOODOO", b"AAA-TODO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/05fdac13-14a7-4d1c-9ddf-2add50242465.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TODO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TODO>>(v1);
    }

    // decompiled from Move bytecode v6
}

