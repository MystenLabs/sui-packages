module 0x6a1fcd92aa230c7284e67ed79465cade0c3926ab7f4bfc7cad093d0a679c5425::frypto {
    struct FRYPTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRYPTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRYPTO>(arg0, 9, b"FRYPTO", b"Farrakh", b"A token that will take to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/656df0cc-8110-4632-bf34-2f9d3a1be9e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRYPTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRYPTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

