module 0x67ca4072c5647b6d87bac9286e07e930ff08f4cfd0c181fa01a18a0f9d814b2b::sani {
    struct SANI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANI>(arg0, 9, b"SANI", b"sanimemeco", b"SANI is a meme coin. A portion of every transaction is automatically donated to approved environmental organizations or projects that focus on clean water, reforestation and waste reduction.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/56e00122-86b4-496b-98d7-dd98f0c6d3f2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SANI>>(v1);
    }

    // decompiled from Move bytecode v6
}

