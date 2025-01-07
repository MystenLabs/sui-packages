module 0x265f5bd50763e46b8d676280428985bd47314d7a9c0f26e7be98269c9427c732::dld {
    struct DLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DLD>(arg0, 9, b"DLD", b"Duck Lord", b"Duck meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cc1ce917-5794-4999-bce0-471322d3e5df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

