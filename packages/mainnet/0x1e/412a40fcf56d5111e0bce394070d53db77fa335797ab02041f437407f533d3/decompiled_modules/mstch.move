module 0x1e412a40fcf56d5111e0bce394070d53db77fa335797ab02041f437407f533d3::mstch {
    struct MSTCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSTCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSTCH>(arg0, 9, b"MSTCH", b"Mustach", b"Who has the best mustache.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7aed0f68-4d3c-4a29-a229-38b5ca917676.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSTCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSTCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

