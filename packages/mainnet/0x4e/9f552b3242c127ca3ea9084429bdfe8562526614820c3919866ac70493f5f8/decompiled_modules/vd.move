module 0x4e9f552b3242c127ca3ea9084429bdfe8562526614820c3919866ac70493f5f8::vd {
    struct VD has drop {
        dummy_field: bool,
    }

    fun init(arg0: VD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VD>(arg0, 5, b"VD", b"vduc", b"testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/06a29620-d895-11ef-9ad1-d96ea2b1225f")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VD>>(v1);
        0x2::coin::mint_and_transfer<VD>(&mut v2, 110000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VD>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

