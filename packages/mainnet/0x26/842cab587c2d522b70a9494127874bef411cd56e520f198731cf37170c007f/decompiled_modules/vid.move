module 0x26842cab587c2d522b70a9494127874bef411cd56e520f198731cf37170c007f::vid {
    struct VID has drop {
        dummy_field: bool,
    }

    fun init(arg0: VID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VID>(arg0, 9, b"VID", b"Did", b"Memasik", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/866ca07f-d604-490d-9acb-61602fa04d4e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VID>>(v1);
    }

    // decompiled from Move bytecode v6
}

