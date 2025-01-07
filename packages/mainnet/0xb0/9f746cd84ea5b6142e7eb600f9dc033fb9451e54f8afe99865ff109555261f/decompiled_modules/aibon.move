module 0xb09f746cd84ea5b6142e7eb600f9dc033fb9451e54f8afe99865ff109555261f::aibon {
    struct AIBON has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIBON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIBON>(arg0, 9, b"AIBON", b"Lem Aibon", b"Its just a glue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/21db3233-559f-42c0-a773-aea5ec0e1732.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIBON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIBON>>(v1);
    }

    // decompiled from Move bytecode v6
}

