module 0xabdf36c0770066a0bc8829c3ca8082c37fcb22278c22adb57193bfcfd7b29d3d::dogs {
    struct DOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGS>(arg0, 9, b"DOGS", b"DOGS on SUI", b"dogs on suichain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/495ccaaa762f18f9faf4c417a24fb4f2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

