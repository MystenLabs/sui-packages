module 0xfd5912e1bd623e4535e3291823fa742192c4ce89083bd1bd25db24547ab3430a::rcr {
    struct RCR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCR>(arg0, 9, b"RCR", b"Rock Token", b"Memecoin for you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb68fa75-fe36-4b5a-a03c-f6e15d61b743.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RCR>>(v1);
    }

    // decompiled from Move bytecode v6
}

