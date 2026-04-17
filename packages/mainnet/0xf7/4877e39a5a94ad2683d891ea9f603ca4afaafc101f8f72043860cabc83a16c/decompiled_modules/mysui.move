module 0xf74877e39a5a94ad2683d891ea9f603ca4afaafc101f8f72043860cabc83a16c::mysui {
    struct MYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYSUI>(arg0, 9, b"SUI", b"Sui Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/lgm1831/sui/refs/heads/main/SUI.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYSUI>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<MYSUI>>(0x2::coin::mint<MYSUI>(&mut v2, 1000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

