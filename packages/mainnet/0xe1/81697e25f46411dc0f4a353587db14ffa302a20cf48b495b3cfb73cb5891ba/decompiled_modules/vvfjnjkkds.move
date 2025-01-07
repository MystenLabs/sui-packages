module 0xe181697e25f46411dc0f4a353587db14ffa302a20cf48b495b3cfb73cb5891ba::vvfjnjkkds {
    struct VVFJNJKKDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VVFJNJKKDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VVFJNJKKDS>(arg0, 9, b"VVFJNJKKDS", b"N79", x"4c6f7361e1baa3656c657364766a6163646b736b777677", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/31eef613-9614-44ad-af0c-f1ecc7b062b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VVFJNJKKDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VVFJNJKKDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

