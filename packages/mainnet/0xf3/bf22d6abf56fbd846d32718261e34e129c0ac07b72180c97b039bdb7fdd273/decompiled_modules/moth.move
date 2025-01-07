module 0xf3bf22d6abf56fbd846d32718261e34e129c0ac07b72180c97b039bdb7fdd273::moth {
    struct MOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOTH>(arg0, 9, b"MOTH", b"MagicMoth", x"41747472616374656420746f2063727970746fe280997320627269676874206c69676874732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cea0da73-2863-4da7-babb-579c8e9d290f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

