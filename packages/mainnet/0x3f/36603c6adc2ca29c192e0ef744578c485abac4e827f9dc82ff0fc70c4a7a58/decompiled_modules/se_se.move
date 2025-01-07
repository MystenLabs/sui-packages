module 0x3f36603c6adc2ca29c192e0ef744578c485abac4e827f9dc82ff0fc70c4a7a58::se_se {
    struct SE_SE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SE_SE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SE_SE>(arg0, 9, b"SE_SE", b"Sese", b"Its a memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b5978a83-de6d-4c98-8b81-e3c746caa006.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SE_SE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SE_SE>>(v1);
    }

    // decompiled from Move bytecode v6
}

