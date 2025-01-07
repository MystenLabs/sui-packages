module 0xa1d9f8a33820791e82010c1e3c745270f13816f2b23ee1ed69bc66506eddea14::pkf {
    struct PKF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKF>(arg0, 9, b"PKF", b"POCKETFI", b"POCKETFI BOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/347cb04b-ed65-4bf5-8030-b62427afdc39.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PKF>>(v1);
    }

    // decompiled from Move bytecode v6
}

