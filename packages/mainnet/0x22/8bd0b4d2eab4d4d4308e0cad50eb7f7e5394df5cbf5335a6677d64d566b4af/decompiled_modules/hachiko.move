module 0x228bd0b4d2eab4d4d4308e0cad50eb7f7e5394df5cbf5335a6677d64d566b4af::hachiko {
    struct HACHIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACHIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HACHIKO>(arg0, 6, b"HACHIKO", b"Hachiko on Sui", b"Hachiko The Ultimate Token inspired by loyalty.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_20_d0f048a4e2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACHIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HACHIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

