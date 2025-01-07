module 0x91c9d6f26302a6e46397b0937adb8d2b2ca15caeec0cd45900a42dbab79f47e7::woof {
    struct WOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOF>(arg0, 6, b"WOOF", b"JamesWOOF", x"4a616d657320576f6f66277320506978656c20556e6976657273650a43756c7469766174652c204578706c6f72652c20616e642043726561746520596f7572204f776e20556e69717565204d656d6f726965730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jwcx_17bed61c72.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

