module 0xb39014100ae0fdf760d84d6a7ca3e6f22fbe209b289326100ca86dc8ae61b6c8::box {
    struct BOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOX>(arg0, 9, b"BOX", b"Box of Toys", b"just a Box of toys for a boy or a girl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4cd7f5acfb524101b4760eaa8f157f9fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

