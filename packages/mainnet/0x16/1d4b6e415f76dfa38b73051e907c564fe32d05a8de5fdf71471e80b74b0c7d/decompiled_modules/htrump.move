module 0x161d4b6e415f76dfa38b73051e907c564fe32d05a8de5fdf71471e80b74b0c7d::htrump {
    struct HTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTRUMP>(arg0, 9, b"HTRUMP", b"Hot Trump", b"Trump gonna make US Hot again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c459a127-dcc1-45c2-9b00-78bd88e86919.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

