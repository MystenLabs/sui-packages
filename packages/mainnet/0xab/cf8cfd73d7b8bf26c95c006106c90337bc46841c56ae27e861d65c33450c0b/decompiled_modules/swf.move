module 0xabcf8cfd73d7b8bf26c95c006106c90337bc46841c56ae27e861d65c33450c0b::swf {
    struct SWF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWF>(arg0, 6, b"Swf", b"Suiwif", x"41732077696720697320746f20736f6c616e612c20776520617265206865726520746f2063726561746520616e6f7468657220776967206f6e205375692e0a0a54686973206973206a7573742074686520626567696e6e696e672e2e206c6574277320676f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1002718976_a939c63038.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWF>>(v1);
    }

    // decompiled from Move bytecode v6
}

