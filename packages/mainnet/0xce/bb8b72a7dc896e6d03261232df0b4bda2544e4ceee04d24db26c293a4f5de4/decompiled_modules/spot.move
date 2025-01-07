module 0xcebb8b72a7dc896e6d03261232df0b4bda2544e4ceee04d24db26c293a4f5de4::spot {
    struct SPOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOT>(arg0, 6, b"SPOT", b"SUIeet Spot", b"Join the only spot that has everything SUI. This is the SUIeet spot for all your SUIeety needs. SUIeet candy, SUIeet tooth, SUIeet juice, come here and let loose. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1803_d123490a22.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

