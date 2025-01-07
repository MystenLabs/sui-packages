module 0x862b223360e9f0f0f0807d416b25ec0280747cc8c14b190ce5c770ba9ee20cec::cck {
    struct CCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCK>(arg0, 9, b"CCK", b"cupcake", b"Popular like its name", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/602e06cc-8b0e-4eae-b194-d56aeec836ce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

