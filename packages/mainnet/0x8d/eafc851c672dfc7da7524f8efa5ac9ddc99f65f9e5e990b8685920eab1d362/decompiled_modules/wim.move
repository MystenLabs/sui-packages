module 0x8deafc851c672dfc7da7524f8efa5ac9ddc99f65f9e5e990b8685920eab1d362::wim {
    struct WIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIM>(arg0, 9, b"WiM", b"Walmon", b"Smule", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1c3cc0bb8c169ec1f05001dece6e6061blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

