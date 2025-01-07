module 0x85ed6780870d54362c8381c3e9d48b163641da0095e54b0666bed80e623a9622::hc {
    struct HC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HC>(arg0, 9, b"HC", b"HASE COIN", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/premium-photo/cute-animal-little-pretty-blue-rabbit-portrait-from-splash-watercolor-illustration_169356-493.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HC>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HC>>(v1);
    }

    // decompiled from Move bytecode v6
}

