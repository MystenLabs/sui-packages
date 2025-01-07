module 0x8c9b2d3ab50880e2690db1c0a1f29bb36317dc0218727ceb0551b4d0264e0e3b::pizzo {
    struct PIZZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIZZO>(arg0, 6, b"PIZZO", b"Pizzo On Sui", b"pizo is the first pizza memecoin on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015969_c2e770fa6b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIZZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIZZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

