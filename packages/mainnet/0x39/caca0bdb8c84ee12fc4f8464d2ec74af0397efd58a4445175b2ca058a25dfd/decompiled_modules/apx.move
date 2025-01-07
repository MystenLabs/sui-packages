module 0x39caca0bdb8c84ee12fc4f8464d2ec74af0397efd58a4445175b2ca058a25dfd::apx {
    struct APX has drop {
        dummy_field: bool,
    }

    fun init(arg0: APX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APX>(arg0, 9, b"APX", b"APIX", b"for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a8dc4e98-9fe7-4cc8-9450-c2b38bca9694.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APX>>(v1);
    }

    // decompiled from Move bytecode v6
}

