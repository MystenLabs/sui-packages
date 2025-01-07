module 0x58c10826a5971088470a811354041b9a8f3b27185ed49d48354ed4cf412a868f::zbe {
    struct ZBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZBE>(arg0, 9, b"ZBE", b"Zombie", b"zombi token minecraft", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9dbff544-04e7-4439-b45c-8d7e19c78454.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

