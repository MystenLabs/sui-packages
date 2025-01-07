module 0xba6dc92d6b7865c6cb191d44430fa059af670bfd3012696a9b5ed40b7081e9e3::rot {
    struct ROT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROT>(arg0, 9, b"ROT", b"Jarrott", b"First meme name java", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dec25c7b-e41c-42ee-8cc1-85b1bc678613.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROT>>(v1);
    }

    // decompiled from Move bytecode v6
}

