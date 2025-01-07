module 0x78ad44c4ff8c80a2eaf348a2e1ec0187d2cf7c17b6f7eacc0307cefef8f203c3::trident {
    struct TRIDENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIDENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIDENT>(arg0, 6, b"TRIDENT", b"Trident on Sui", b"Trident: The Meme Coin That Rules the $SUI Waves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735487466416.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRIDENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIDENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

