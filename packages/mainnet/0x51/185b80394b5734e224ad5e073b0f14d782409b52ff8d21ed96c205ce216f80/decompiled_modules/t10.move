module 0x51185b80394b5734e224ad5e073b0f14d782409b52ff8d21ed96c205ce216f80::t10 {
    struct T10 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T10, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T10>(arg0, 9, b"T10", b"Topgun", b"A token for nothing. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1b330c3-e7ff-49a1-9d19-3c955eb0ecdf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T10>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T10>>(v1);
    }

    // decompiled from Move bytecode v6
}

