module 0x7f4505ca9ab2de08e42b2653386a1fa38171c0db6b7c364a1b8927d018263bd1::tpn {
    struct TPN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPN>(arg0, 9, b"TPN", b"TPAIN", b"Renewed Hope", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b0ea7d79-d0e7-4234-bd09-6f7dd0baa12a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPN>>(v1);
    }

    // decompiled from Move bytecode v6
}

