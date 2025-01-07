module 0xb6124b8aabb333bd38e76c81441024ae189717451607b1b0a4c9f2cd71ec6b95::evo {
    struct EVO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVO>(arg0, 9, b"EVO", b"Evolve", b"Evolve Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/88096605-b1e4-49a0-b721-35ab7117e241-1000022990.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVO>>(v1);
    }

    // decompiled from Move bytecode v6
}

