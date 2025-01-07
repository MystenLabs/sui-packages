module 0x2f2e90ef7fbeccd53d90f621b2e8c069c49b705016ded7b96247345329ed723f::wyrump {
    struct WYRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WYRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WYRUMP>(arg0, 9, b"WYRUMP", b"Trump Wewe", b"Mmee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb1f14fc-0ed9-4464-b9a9-61c698479b85.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WYRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WYRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

