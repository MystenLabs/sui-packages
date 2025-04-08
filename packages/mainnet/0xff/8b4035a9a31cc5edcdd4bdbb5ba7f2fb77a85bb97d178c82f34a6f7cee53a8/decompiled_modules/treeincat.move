module 0xff8b4035a9a31cc5edcdd4bdbb5ba7f2fb77a85bb97d178c82f34a6f7cee53a8::treeincat {
    struct TREEINCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREEINCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREEINCAT>(arg0, 6, b"TREEINCAT", b"Tree stuck in cat", b"TREEINCAT - Tree Stuck in Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Z_Ko5r1_W_400x400_2de442c0ab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREEINCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREEINCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

