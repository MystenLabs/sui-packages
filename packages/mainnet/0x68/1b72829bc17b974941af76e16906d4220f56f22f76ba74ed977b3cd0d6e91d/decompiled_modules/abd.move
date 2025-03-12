module 0x681b72829bc17b974941af76e16906d4220f56f22f76ba74ed977b3cd0d6e91d::abd {
    struct ABD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABD>(arg0, 9, b"ABD", b"Abdul ", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e613e8e-f898-4cfb-9675-1f686b6a060f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABD>>(v1);
    }

    // decompiled from Move bytecode v6
}

