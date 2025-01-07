module 0xb68f8d916dd1e660d9bfc937711f9ffda7d0c20fadd0fa0d1d8a71b173911efe::wit {
    struct WIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIT>(arg0, 6, b"WIT", b"Cat Wit Seal", b"Just a cat wit seal costume.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3407_2c5fcf3e2d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

