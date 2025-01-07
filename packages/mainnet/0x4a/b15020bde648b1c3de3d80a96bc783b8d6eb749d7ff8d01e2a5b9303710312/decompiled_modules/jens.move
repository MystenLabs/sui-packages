module 0x4ab15020bde648b1c3de3d80a96bc783b8d6eb749d7ff8d01e2a5b9303710312::jens {
    struct JENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JENS>(arg0, 6, b"JENS", b"O.G JENKINS", b"Jenkins is an old man who lives carefree, enjoys everything he does, now Jenkins has emerged as a strong and strange person in the new world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046283_ffccbe3854.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

