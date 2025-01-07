module 0x2ecdec4f08b3481febbbe53661c72ec7292a4d953e905d9e2eca07e7413de9c0::char {
    struct CHAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAR>(arg0, 9, b"CHAR", b"Charentais", b"Charentaise lande ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bb57e6a4-105e-48a8-9a45-bbeb48626c24.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

