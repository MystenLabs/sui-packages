module 0x9382aff834a0438bf5717caa3c625b5e22e76e8922a304778338d6be177e221e::fcat {
    struct FCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCAT>(arg0, 9, b"FCAT", b"FAIRY CAT", b"A FAIRY CAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1ebf37ba-129f-41bf-a024-fcfa3a996a80.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

