module 0xe7e2c64ec6f8f218a5dc8838975eb498de53a7cd64282de1afa27fc2e4fcd760::blubbonk {
    struct BLUBBONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBBONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBBONK>(arg0, 6, b"BLUBBONK", b"BLUB BONK", b"BLUBBONK Meme on sui like Blub", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x6f81a28efac1bcd1e6038cdd04baf8263b50303338f707a7e7ae882c6b877ebe_bbonk_bbonk_521f775659.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBBONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUBBONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

