module 0x7e616e9c71602f9b070df0939b0f1f180e7575e40294e1213e3d7cca6e7645f8::suga {
    struct SUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGA>(arg0, 6, b"SUGA", b"Sui Maga", x"496e74726f647563696e672024535547412c200a0a74686520756c74696d617465206d656d65206f6e207375690a0a245355474120636f6d62696e65732068756d6f722c20436f6d6d756e697479207370697269742c20616e6420496e6e6f766174696f6e20746f2063726561746520756e6971756520546f6b656e2064657369676e656420666f722074686f73652077686f2077616e7420746f206d616b65206d656d657320677265617420616761696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027317_2614e0a291.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

