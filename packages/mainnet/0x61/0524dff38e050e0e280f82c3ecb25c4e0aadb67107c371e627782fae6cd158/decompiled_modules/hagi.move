module 0x610524dff38e050e0e280f82c3ecb25c4e0aadb67107c371e627782fae6cd158::hagi {
    struct HAGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAGI>(arg0, 9, b"HAGI", b"Rahagi", b"Rahagi token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2aa1c8e8-881c-4793-9521-b25460839178.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

