module 0xacd9113ab466e37f480ad16e3cad965d5043f7404176627bfcea9684514221ba::gaa {
    struct GAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAA>(arg0, 9, b"GAA", b"goats", b"goats token based on nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/69101e3d-8f24-4df0-ad94-bf3ab6cb3a45.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

