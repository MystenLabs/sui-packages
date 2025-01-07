module 0x6e819348a95ce2e8b7609d9c488fd3434fdcd0b8d271959911ab072810f10a19::whattelse {
    struct WHATTELSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHATTELSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHATTELSE>(arg0, 9, b"WHATTELSE", b"Whatttt", b"Whaaaat this ? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f97c62c-aa0b-4ddd-85a5-f9a5468f6ef8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHATTELSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHATTELSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

