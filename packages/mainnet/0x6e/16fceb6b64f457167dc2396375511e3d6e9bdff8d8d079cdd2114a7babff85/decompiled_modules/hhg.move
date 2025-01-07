module 0x6e16fceb6b64f457167dc2396375511e3d6e9bdff8d8d079cdd2114a7babff85::hhg {
    struct HHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHG>(arg0, 9, b"HHG", b"Hhj", b"Fgh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa7002a9-f9e4-4049-82f3-8eca272a0df3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHG>>(v1);
    }

    // decompiled from Move bytecode v6
}

