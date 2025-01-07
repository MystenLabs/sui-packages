module 0xe95bf0f744e23145f0b1d715af02d59751d5b04c5f36b97f1eceb201fd51fa90::b {
    struct B has drop {
        dummy_field: bool,
    }

    fun init(arg0: B, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B>(arg0, 9, b"B", b"beo", b"Community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30ab62ca-a92d-4698-ad0f-d11de190a5f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<B>>(v1);
    }

    // decompiled from Move bytecode v6
}

