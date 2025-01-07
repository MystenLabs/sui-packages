module 0x447d9deb0e31d0fa61a4506f45dd8dcac5453e1db0c3f8c04812ecc174649e73::mjj {
    struct MJJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MJJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MJJ>(arg0, 9, b"MJJ", b"Barssmj", b"Great meme for pay money ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5b4011b4-7f9d-46fc-93d4-bc15d447c366.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MJJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MJJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

