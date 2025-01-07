module 0x11bae03ea1912a07da0461a85499582f19d5b03410d644e9b4ebf1e43400df1e::ad9 {
    struct AD9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AD9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AD9>(arg0, 9, b"AD9", b"Android 9", b"Android number nine", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/0d565f623a95cf7ceada8dd070bbaa1fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AD9>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AD9>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

