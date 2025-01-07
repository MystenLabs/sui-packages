module 0x21d5c62f6c4876cb44defddcd94b622dd694906f69369eb78a05583f0cf57b7c::dha {
    struct DHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DHA>(arg0, 9, b"DHA", b"manhdha", b"manhdha toeken meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1c9eed8-cb12-4e7e-aa7e-e01742aebc0d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

