module 0x69784ae95877c528e35b575f0f4170e396ad4dcd665d2631ce7cef0e8a88bd0a::bli {
    struct BLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLI>(arg0, 6, b"BLI", b"Billai", x"42494c4c2e414920e280932054686520414920e2808be2808b5265766f6c7574696f6e206f6e20426c6f636b636861696e20496d6167696e65206120636f696e207468617420636f6d62696e65732074686520706f776572206f6620414920616e6420626c6f636b636861696e20e28093207768657265206576657279207472616e73616374696f6e206973206e6f74206f6e6c7920666173742c207472616e73706172656e742062757420616c736f20736d6172746572207468616e20657665722e2042494c4c2e4149206973207468652070696f6e65657220636f696e20696e2074686973206669656c642120446563656e7472616c697a656420626c6f636b636861696e3a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/9c48e5c7-6eab-41dd-b0d5-31cbff914d8e.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

