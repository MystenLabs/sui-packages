module 0x3f0de907de2327b10bb40a1a8df52d8110bbbd3d7a038deff02b1b6b849c0911::hui {
    struct HUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUI>(arg0, 6, b"HUI", b"Halal Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSupbVb67w7NMurR10vbvO7YjaDKHo8EK1KTA&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HUI>(&mut v2, 7777777778000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

