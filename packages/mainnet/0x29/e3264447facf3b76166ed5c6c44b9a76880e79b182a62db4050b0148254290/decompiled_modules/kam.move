module 0x29e3264447facf3b76166ed5c6c44b9a76880e79b182a62db4050b0148254290::kam {
    struct KAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAM>(arg0, 6, b"KaM", b"KaaaM", b"Kaaatius Maaaximus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2126_ead1ed8c88.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

