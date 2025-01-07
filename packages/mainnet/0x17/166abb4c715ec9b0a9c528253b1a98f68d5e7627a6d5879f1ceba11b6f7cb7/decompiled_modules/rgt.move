module 0x17166abb4c715ec9b0a9c528253b1a98f68d5e7627a6d5879f1ceba11b6f7cb7::rgt {
    struct RGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RGT>(arg0, 9, b"RGT", b"Regent", b"Be Brave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f14d461f-d39a-41f2-a611-8d84960cff81.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

