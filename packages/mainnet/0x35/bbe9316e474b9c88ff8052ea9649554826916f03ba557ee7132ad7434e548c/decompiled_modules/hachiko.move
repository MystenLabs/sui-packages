module 0x35bbe9316e474b9c88ff8052ea9649554826916f03ba557ee7132ad7434e548c::hachiko {
    struct HACHIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACHIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HACHIKO>(arg0, 6, b"HACHIKO", b"Hachiko", b"The memecoin based on the legendary Akita dog from Japan HACHIKO.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dog_89e968b55c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACHIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HACHIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

