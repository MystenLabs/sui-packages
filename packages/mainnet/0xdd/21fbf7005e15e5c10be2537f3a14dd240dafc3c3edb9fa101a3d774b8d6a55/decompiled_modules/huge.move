module 0xdd21fbf7005e15e5c10be2537f3a14dd240dafc3c3edb9fa101a3d774b8d6a55::huge {
    struct HUGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUGE>(arg0, 9, b"HUGE", b"HUGE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.oaiusercontent.com/file-KkymroWTi8S79Qofpi5v2N?se=2025-02-11T06%3A26%3A43Z&sp=r&sv=2024-08-04&sr=b&rscc=max-age%3D604800%2C%20immutable%2C%20private&rscd=attachment%3B%20filename%3D0d093543-01ff-4172-9f12-a07b071c48f9.webp&sig=txbKRnCZU4hFQY6kwDN/YzT6D3UAUYsVzmoyJYv/F8s%3D")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUGE>>(v1);
        0x2::coin::mint_and_transfer<HUGE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUGE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

