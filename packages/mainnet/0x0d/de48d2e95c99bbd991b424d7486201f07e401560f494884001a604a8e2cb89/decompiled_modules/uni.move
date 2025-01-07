module 0xdde48d2e95c99bbd991b424d7486201f07e401560f494884001a604a8e2cb89::uni {
    struct UNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNI>(arg0, 6, b"Uni", b"Sea Urchin (UNI)", b"The first sea urchin wearing a hat on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_a_a_a_a_a_a_a_2024_10_08_202112_e74227c82a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

