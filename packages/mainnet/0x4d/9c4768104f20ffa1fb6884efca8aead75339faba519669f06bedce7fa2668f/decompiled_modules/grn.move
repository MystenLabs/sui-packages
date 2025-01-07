module 0x4d9c4768104f20ffa1fb6884efca8aead75339faba519669f06bedce7fa2668f::grn {
    struct GRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRN>(arg0, 9, b"GRN", b"Greeen", b"Greeen Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/07382e38-fcb0-41e2-9fe7-4ddb85995453.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRN>>(v1);
    }

    // decompiled from Move bytecode v6
}

