module 0x28bc233c1cd5091e24c68e1b1a46f38a470a04a8e83317a43a2b610f3f1a0466::kitti {
    struct KITTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITTI>(arg0, 9, b"KITTI", b"Bold", b"We have first hand marketing tools in web3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/60baebc5-3581-4b89-b7da-9ed7d65fa239.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KITTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

