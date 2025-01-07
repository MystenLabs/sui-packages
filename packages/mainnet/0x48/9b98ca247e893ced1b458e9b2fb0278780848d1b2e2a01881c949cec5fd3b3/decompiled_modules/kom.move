module 0x489b98ca247e893ced1b458e9b2fb0278780848d1b2e2a01881c949cec5fd3b3::kom {
    struct KOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOM>(arg0, 9, b"KOM", b"KOMODO", b"MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaLKqWddV1Itjp-KLu8xQTWwlMD9AKBSthTo-Bx-VOFszBRaLfA271egtG&s=10")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KOM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

