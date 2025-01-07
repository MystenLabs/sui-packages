module 0xb3e2204bb83aee29f7a4805e46bd64be7f75e5a1e7d03ba19d89f44562ce5f3e::pwaty {
    struct PWATY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWATY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWATY>(arg0, 6, b"PWATY", b"Pwaty On Sui", b"Pwaty the cute penguin that will become an icon on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014727_ef188d124e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWATY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWATY>>(v1);
    }

    // decompiled from Move bytecode v6
}

