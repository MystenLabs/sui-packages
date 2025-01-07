module 0xeb47e9e0f63126b70c55191217a7abd21e5dd9fa8863fa9ade2c0bf4f26aeb50::vrd {
    struct VRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: VRD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VRD>(arg0, 3, b"VRD", b"VRD", b"VRD is a coin for the VRD project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/d7cFZXt/portomasonet.png")), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VRD>>(v2);
        0x2::coin::mint_and_transfer<VRD>(&mut v3, 900000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VRD>>(v3, v0);
    }

    // decompiled from Move bytecode v6
}

