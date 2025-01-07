module 0x6e0ec9da4571654cb7b40a3637dd4b63cada5ee184d4fb4c38de2201aa05b254::gm {
    struct GM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GM>(arg0, 9, b"GM", b"GummyBear ", b"Just the bear, but gummy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b3039865-cfdb-4717-b091-0da0276526a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GM>>(v1);
    }

    // decompiled from Move bytecode v6
}

