module 0x1304c847823ca775dd654dd632288502da074e944649cdc0c7e54ac0524cc8ee::oktid {
    struct OKTID has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKTID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OKTID>(arg0, 9, b"OKTID", b"OCTOKID", b"Meme Octopus kid ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/99d89145-5bdd-4259-9ff4-51e55f978d98.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKTID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OKTID>>(v1);
    }

    // decompiled from Move bytecode v6
}

