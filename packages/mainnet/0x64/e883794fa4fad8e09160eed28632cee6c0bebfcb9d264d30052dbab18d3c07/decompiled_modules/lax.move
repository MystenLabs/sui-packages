module 0x64e883794fa4fad8e09160eed28632cee6c0bebfcb9d264d30052dbab18d3c07::lax {
    struct LAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAX>(arg0, 6, b"LAX", b"Lax", b"Lax is a mysterious purple creature who has mastered the art of doing absolutely nothing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pumpimg_904d5cb225.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

