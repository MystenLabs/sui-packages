module 0x28c3a48465f5056ebb793da237ef5808ddf70c7833bcc06f290ae32942efc934::bsk {
    struct BSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSK>(arg0, 9, b"BSK", b"Babyshark", x"46616d6f757320666f722074686569722073706565642c20737472656e6774682c20616e642064657465726d696e6174696f6e2042616279736861726b732074687269766520696e20537569e280997320626c6f636b636861696e206f6365616e2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ee3260740e8fb3574ed8274ed0d01afbblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

