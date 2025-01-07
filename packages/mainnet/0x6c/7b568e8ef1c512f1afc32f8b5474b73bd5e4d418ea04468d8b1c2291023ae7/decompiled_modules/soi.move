module 0x6c7b568e8ef1c512f1afc32f8b5474b73bd5e4d418ea04468d8b1c2291023ae7::soi {
    struct SOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOI>(arg0, 9, b"SOI", b"Soii", b"Soii token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/695d6a17-e463-474a-92ba-284bc6d6bebc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

