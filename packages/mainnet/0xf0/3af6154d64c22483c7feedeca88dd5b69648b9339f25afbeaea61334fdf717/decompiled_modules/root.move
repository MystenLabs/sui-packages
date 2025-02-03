module 0xf03af6154d64c22483c7feedeca88dd5b69648b9339f25afbeaea61334fdf717::root {
    struct ROOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROOT>(arg0, 9, b"ROOT", b"Rootlets", b"Just Root It", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/s9Cd7BgQ/download-4.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ROOT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

