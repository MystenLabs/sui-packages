module 0x36fa9b285b37c8517a7eb0c5693167a4197f988d88494635a3545c53a1dbe690::pedrolito {
    struct PEDROLITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEDROLITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEDROLITO>(arg0, 6, b"Pedrolito", b"Fich", b"Good vibes ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731323827398.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEDROLITO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEDROLITO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

