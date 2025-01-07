module 0x6701659dbbc69c8f1a097db40a06e18ad00acd41b1c1ef7b7c6743ecc4c2b3e8::kido {
    struct KIDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIDO>(arg0, 9, b"KIDO", b"KAIDAWG", b"KAIDAWG is a black poodle with name Kevin. He is like to chase motorcycle and bark at strangers to ask for belly rubs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bbce9b99-7515-4553-abba-55be03686caf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

