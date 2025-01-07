module 0xe95cb1cdb4a98b069c4528cdc37a3243cb68ec9dcf100d0d9e68d313c5c758d8::beelyamin {
    struct BEELYAMIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEELYAMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEELYAMIN>(arg0, 9, b"BEELYAMIN", b"Bilyaminu ", b"I love memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/72bcd0e9-1404-4714-9971-134082c30762.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEELYAMIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEELYAMIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

