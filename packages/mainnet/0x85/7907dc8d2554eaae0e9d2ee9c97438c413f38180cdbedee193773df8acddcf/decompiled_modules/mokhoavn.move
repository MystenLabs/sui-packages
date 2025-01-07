module 0x857907dc8d2554eaae0e9d2ee9c97438c413f38180cdbedee193773df8acddcf::mokhoavn {
    struct MOKHOAVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOKHOAVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOKHOAVN>(arg0, 9, b"MOKHOAVN", b"Mokhoa", b"Unlock code", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/354c70e2-7ea3-4f34-a3df-c7271e4f43ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOKHOAVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOKHOAVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

