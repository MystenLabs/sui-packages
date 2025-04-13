module 0x625cea8daeda972f689a2d98962bb8a7c6626e7fe562af3d8313a502d75d2ed0::grv {
    struct GRV has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRV>(arg0, 9, b"GRV", b"grynv", b"n,jbbjxkhjasvxhasvckhjackvcxjxbnblcbhlclhc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a42a39d8e0bb00ebd28f1aadf49f7e59blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

