module 0x777aec44b6a7669a3796714c2e6883187ca5a407741880f66d532285e511c61::mos {
    struct MOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOS>(arg0, 9, b"MOS", b"MOSHI", b"MOSHOLBANAMAK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/166f4f8a-eb44-4138-b031-52a1f9da0c60.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

