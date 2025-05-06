module 0xc971d25eb9cf487366bbc3909b4b13f812903b3611e42f70d1cad70c7d43ba2a::boom2 {
    struct BOOM2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOM2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOM2>(arg0, 9, b"BOOM2", b"boom2", b"love boom2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOM2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOM2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

