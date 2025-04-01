module 0x505a36f71b6564328e49aa919e3f96b849b093aa590a5935fb4d0ad8eb1901a8::si {
    struct SI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SI>(arg0, 9, b"SI", b"SUI", b"token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ffe34611c84340d433b76a779b0e87beblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

