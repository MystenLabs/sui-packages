module 0x68a46a2abf2718f113e26775d4a6980cfa65d3c864029d907ca6e143fa85a04e::cata {
    struct CATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATA>(arg0, 9, b"CATA", b"dayo akina", b"I love cats ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2468359b-7199-45e6-8ae7-c728dbde1bc5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

