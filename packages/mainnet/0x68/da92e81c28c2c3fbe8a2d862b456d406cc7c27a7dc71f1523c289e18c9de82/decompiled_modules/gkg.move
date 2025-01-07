module 0x68da92e81c28c2c3fbe8a2d862b456d406cc7c27a7dc71f1523c289e18c9de82::gkg {
    struct GKG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GKG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GKG>(arg0, 9, b"GKG", b"Ginkgo", b"Goethe's Tree", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3294dbcd-4e32-4b72-b664-648bf4f98a15.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GKG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GKG>>(v1);
    }

    // decompiled from Move bytecode v6
}

