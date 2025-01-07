module 0x110599606c82128a8f5f021e611e92e0ae3725578290fc4a20e527cc9f2f2f1e::gen {
    struct GEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEN>(arg0, 9, b"GEN", b"hdje", b"jsn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f562af13-fe9e-40aa-911c-337e21bf375b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

