module 0x629d31addf59ff6680736caccbe65e2d9fc5f50508c89f4ccc69186a06d385db::bad {
    struct BAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAD>(arg0, 9, b"BAD", b"Badbeast", b"Beast is back", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/38e7c123-b6ef-4009-ad5c-83c45a732aec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

