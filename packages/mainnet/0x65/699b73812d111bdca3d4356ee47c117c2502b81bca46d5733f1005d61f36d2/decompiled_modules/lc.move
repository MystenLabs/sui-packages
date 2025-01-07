module 0x65699b73812d111bdca3d4356ee47c117c2502b81bca46d5733f1005d61f36d2::lc {
    struct LC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LC>(arg0, 9, b"LC", b"LordCinder", b"Meme Token for Fanatic Lord Cinder DS!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf2055c4-d3fa-47b6-8086-0c49101ee0d9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LC>>(v1);
    }

    // decompiled from Move bytecode v6
}

