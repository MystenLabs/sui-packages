module 0xb7b0fc625cdf5a960bd3f51821c7781e02ba7ca51d586d4fb8666b9c06e4af93::ovb {
    struct OVB has drop {
        dummy_field: bool,
    }

    fun init(arg0: OVB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OVB>(arg0, 9, b"OVB", b"ovb1001", b"new hero in the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b7ce16839c15b62772286b2867084646blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OVB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OVB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

