module 0x2507e29d9f7a29db9c92860fc34124fc39dd73bc744c07e5a58178e8b67f9c55::lol {
    struct LOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOL>(arg0, 9, b"LOL", b"LOLmeme", b"Just For Laughs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/71536378-e482-4d04-9e67-06bf409046d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

