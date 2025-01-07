module 0x79b347d344af354c525216504e4f63ea5df595e9bc70c8bce828ca92a4212408::turbi {
    struct TURBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBI>(arg0, 6, b"TURBI", b"Turbi", b"Turbos finance meme token $turbi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730791305285.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

