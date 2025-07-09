module 0xd49be7851cae959a4b4ea322ee982fbb76ccc1b25642ee0b77bec0dc31ddf36c::mac {
    struct MAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAC>(arg0, 9, b"Mac", b"MacEveryThing", b"We can say this MacBook, Mac&Cheese, or else whatever you want", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/43c91197c4130533cef0e04f833ff949blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

