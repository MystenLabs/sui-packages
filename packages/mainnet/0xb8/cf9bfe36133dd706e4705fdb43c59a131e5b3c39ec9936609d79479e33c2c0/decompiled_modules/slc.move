module 0xb8cf9bfe36133dd706e4705fdb43c59a131e5b3c39ec9936609d79479e33c2c0::slc {
    struct SLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLC>(arg0, 9, b"SLC", b"Salacoin ", b"Salacoin (SLC): Versatile cryptocurrency for seamless transactions, rewards & interactions across gaming, e-commerce, social & charity ecosystems", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7530b285-f278-44b2-ae67-1dfbf6584d6b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLC>>(v1);
    }

    // decompiled from Move bytecode v6
}

