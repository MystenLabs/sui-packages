module 0x1d7376c3e60869fc2aaa3262b7793697407c1efe8573260a54663904c925fe67::banana {
    struct BANANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANANA>(arg0, 9, b"BANANA", b"Banana", b"A Simple Banana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1i9QWLVSxDQVvfRyRE4t2gKUtYmhOJEsLeA&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BANANA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANANA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

