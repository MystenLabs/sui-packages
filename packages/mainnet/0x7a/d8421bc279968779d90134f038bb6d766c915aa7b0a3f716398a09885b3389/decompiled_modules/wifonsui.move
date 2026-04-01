module 0x7ad8421bc279968779d90134f038bb6d766c915aa7b0a3f716398a09885b3389::wifonsui {
    struct WIFONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFONSUI>(arg0, 6, b"WIFONSUI", b"WIF ON SUI", b"WIF IS NOW ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003650_235bba6651.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

