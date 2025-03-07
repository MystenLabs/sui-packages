module 0x3d7b91ee768a534e62ae58a43a470a85f6454e891ddc29eea46ee079cc0cedab::t41 {
    struct T41 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T41, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T41>(arg0, 9, b"T41", b"Token41", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6TrakUcDrsHf-41q2AsXH6ifQrgV76oIGCw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<T41>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T41>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T41>>(v2);
    }

    // decompiled from Move bytecode v6
}

