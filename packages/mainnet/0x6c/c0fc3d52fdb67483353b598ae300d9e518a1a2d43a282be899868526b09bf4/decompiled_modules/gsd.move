module 0x6cc0fc3d52fdb67483353b598ae300d9e518a1a2d43a282be899868526b09bf4::gsd {
    struct GSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSD>(arg0, 9, b"GSD", b"SFDG", b"VXCZV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a4ab6d9d-540f-40d7-92ab-70d39b903b39.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

