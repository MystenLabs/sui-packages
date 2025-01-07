module 0xa2c7cdcece225b86ccfcedcdebcf5c26577be3d74031f3438d549c803416dbdd::catcry {
    struct CATCRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATCRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATCRY>(arg0, 9, b"CATCRY", b"CatCry", b"Why airdrop ban me ???", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6c14adbf-5cd6-4603-a8bd-810ec1fc9e95.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATCRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATCRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

