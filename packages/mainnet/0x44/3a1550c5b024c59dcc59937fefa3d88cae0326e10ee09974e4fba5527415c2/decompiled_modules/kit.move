module 0x443a1550c5b024c59dcc59937fefa3d88cae0326e10ee09974e4fba5527415c2::kit {
    struct KIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIT>(arg0, 9, b"KIT", b"Lost Kit", b"The best kit in the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86d046f2-4c7e-421c-b56d-fc43122ee383.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

