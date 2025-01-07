module 0xbbbe704c5ed424ff4008297b8333eb1bf2f880053eb22ff2fe93bacda05342ca::flw {
    struct FLW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLW>(arg0, 9, b"FLW", b"Flower", b"flowers need protection and they should be in glass jars, help them to stay alive BUY BUY BUY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f5069be1-0d6c-436e-afa9-db72ab2dd827.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLW>>(v1);
    }

    // decompiled from Move bytecode v6
}

