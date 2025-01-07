module 0xcb972c46f7fd466e1ca4354d283f6ca8ec347cf06ea30db253cdad2a6758a32a::imp {
    struct IMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMP>(arg0, 9, b"IMP", b"Imperium", b"Imperium (IMP) is the official currency of the Helia Empire, a planet located near the star Cassiopeia.    ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9f05c35c-4f46-4150-a673-8097a2d04400.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

