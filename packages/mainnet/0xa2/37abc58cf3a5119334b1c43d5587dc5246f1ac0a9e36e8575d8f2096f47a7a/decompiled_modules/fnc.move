module 0xa237abc58cf3a5119334b1c43d5587dc5246f1ac0a9e36e8575d8f2096f47a7a::fnc {
    struct FNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNC>(arg0, 9, b"FNC", b"FINCOIN", x"43525950544f2054414b494e4720594f5520544f20414e4f54484552204c4556454c204ce29c88efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aca6770a-96f7-4ab6-8911-aca4ce587109.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

