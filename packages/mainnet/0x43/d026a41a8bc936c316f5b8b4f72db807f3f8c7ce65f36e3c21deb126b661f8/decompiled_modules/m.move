module 0x43d026a41a8bc936c316f5b8b4f72db807f3f8c7ce65f36e3c21deb126b661f8::m {
    struct M has drop {
        dummy_field: bool,
    }

    fun init(arg0: M, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M>(arg0, 9, b"M", b"Mouse", x"46756e20746f6b656e204d69636b6579204d6f757365202e200a4f6666696369616c20737461727420736561736f6e2031202e200a6279206d6520627579206d6520627579206d65202e202020202020202020202020202020202020202020202020202030332e30312e32303235", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f4ac2019f2e6925300912dcb6ad3c21fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

