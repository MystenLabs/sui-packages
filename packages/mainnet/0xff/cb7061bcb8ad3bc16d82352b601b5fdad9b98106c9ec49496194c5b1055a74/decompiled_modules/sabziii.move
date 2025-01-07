module 0xffcb7061bcb8ad3bc16d82352b601b5fdad9b98106c9ec49496194c5b1055a74::sabziii {
    struct SABZIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SABZIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SABZIII>(arg0, 9, b"SABZIII", b"GREEN", b"unlimited vegetables", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/de385eb2-9c4e-464d-978b-979fc6501fe8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SABZIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SABZIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

