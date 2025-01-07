module 0x4621520791164ae22d29c4502ed3684c963ed45e6fb241771a317b5925a5aaf3::fox {
    struct FOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOX>(arg0, 9, b"FOX", b"LITTER FOX", b"inspired by fairy tales, myths", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/66593219-fdae-4c3f-9028-e5d534a408f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

