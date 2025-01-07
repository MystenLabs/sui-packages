module 0xea63cf210c19cfe7b54357475105c95446e7afd961d7226a8172ede3fba3d3c6::yawn {
    struct YAWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAWN>(arg0, 6, b"YAWN", b"Yawn's World", b"The crypto world is waking up to $YAWN on the SUI network..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prop_359f72f125.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

