module 0xd91d0df168855a14127d05370a366cbc7cb480bcf28d103f1c280e2c8f9a0f0d::jino {
    struct JINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JINO>(arg0, 6, b"Jino", b"Jimmy & Nova", b"CUTE TWIN DOGS ON SUI ECOSYSTEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000153067_2271a2bf76.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

