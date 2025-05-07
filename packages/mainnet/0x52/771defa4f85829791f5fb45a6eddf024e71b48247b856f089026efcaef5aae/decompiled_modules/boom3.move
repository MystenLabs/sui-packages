module 0x52771defa4f85829791f5fb45a6eddf024e71b48247b856f089026efcaef5aae::boom3 {
    struct BOOM3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOM3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOM3>(arg0, 9, b"BOOM3", b"boom3", b"love boom3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOOM3>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOM3>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

