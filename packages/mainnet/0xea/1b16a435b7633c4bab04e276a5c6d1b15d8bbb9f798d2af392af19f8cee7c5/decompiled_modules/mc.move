module 0xea1b16a435b7633c4bab04e276a5c6d1b15d8bbb9f798d2af392af19f8cee7c5::mc {
    struct MC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MC>(arg0, 9, b"MC", b"Memecoin", b"Memecoin Splash", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6bd803a1a0599fdee0f1d2009ed7e8e0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

