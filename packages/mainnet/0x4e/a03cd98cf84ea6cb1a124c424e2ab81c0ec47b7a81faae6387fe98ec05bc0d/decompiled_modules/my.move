module 0x4ea03cd98cf84ea6cb1a124c424e2ab81c0ec47b7a81faae6387fe98ec05bc0d::my {
    struct MY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY>(arg0, 9, b"My", b"monky23", b"xd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/32c8cfd1fad698317f49f10bb84ae6b9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

