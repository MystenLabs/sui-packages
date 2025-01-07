module 0xb3352e5626f326f7e5b6590f28cd28f6cb315acf2accb1bc7d8421ca80379fc2::prtn {
    struct PRTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRTN>(arg0, 9, b"PRTN", b"PROTON", b"Proton ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e8e084b8-d9a8-45d5-9d70-a6f1e32a9868.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRTN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRTN>>(v1);
    }

    // decompiled from Move bytecode v6
}

