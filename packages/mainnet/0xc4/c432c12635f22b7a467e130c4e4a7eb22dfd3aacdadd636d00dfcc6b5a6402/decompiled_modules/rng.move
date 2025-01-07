module 0xc4c432c12635f22b7a467e130c4e4a7eb22dfd3aacdadd636d00dfcc6b5a6402::rng {
    struct RNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RNG>(arg0, 9, b"RNG", b"ORANGE", b"orange is here for youuuu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ac0997db-b9d5-4b07-b6fa-95cfdfd6dbcf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

