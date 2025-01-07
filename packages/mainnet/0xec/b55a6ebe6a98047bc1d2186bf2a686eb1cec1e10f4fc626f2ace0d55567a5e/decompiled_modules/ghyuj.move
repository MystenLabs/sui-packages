module 0xecb55a6ebe6a98047bc1d2186bf2a686eb1cec1e10f4fc626f2ace0d55567a5e::ghyuj {
    struct GHYUJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHYUJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHYUJ>(arg0, 9, b"GHYUJ", b"fghfgd", b"xdfgdfgdfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/97c14d67-9903-49db-8661-ea75f240d7f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHYUJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHYUJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

