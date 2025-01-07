module 0x141568dd985d18531c60589dd9e38f083af8670fb87ac37348c279ca5dd943ba::skbd {
    struct SKBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKBD>(arg0, 9, b"SKBD", b"Skibidi", b"Skibidi dop dop dop yes yes, Skibidi dabudu neep neep", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/541a436f-e065-4cea-8a7b-2b437dd4a59c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

