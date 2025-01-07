module 0xaf638ac5755fdb91d121b19604a7f45e70df6f21820262c2c8128c1eb374997a::bbt {
    struct BBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBT>(arg0, 9, b"BBT", b"BabyTuyen", b"My girl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dd795140-5892-49d5-ac2d-5217e7438296.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

