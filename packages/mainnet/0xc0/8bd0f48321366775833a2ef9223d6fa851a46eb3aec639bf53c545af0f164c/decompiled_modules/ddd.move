module 0xc08bd0f48321366775833a2ef9223d6fa851a46eb3aec639bf53c545af0f164c::ddd {
    struct DDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDD>(arg0, 9, b"DDD", b"LUIGI", b"IYKYK. This man is not alone in his feelings. Should this coin turn a profit, it will go towards charity for those who struggle to get proper healthcare. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7db0cd38-ed76-480a-899d-9312a24cb1bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

