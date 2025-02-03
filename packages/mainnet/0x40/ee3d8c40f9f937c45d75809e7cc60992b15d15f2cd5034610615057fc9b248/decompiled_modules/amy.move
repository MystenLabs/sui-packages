module 0x40ee3d8c40f9f937c45d75809e7cc60992b15d15f2cd5034610615057fc9b248::amy {
    struct AMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMY>(arg0, 9, b"AMY", b"Amiryasm", b"Amlljhk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/113ee05b-1ae3-465b-9b5c-5e8b2d824ab2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

