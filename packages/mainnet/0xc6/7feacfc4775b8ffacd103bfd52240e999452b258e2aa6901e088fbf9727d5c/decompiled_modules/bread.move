module 0xc67feacfc4775b8ffacd103bfd52240e999452b258e2aa6901e088fbf9727d5c::bread {
    struct BREAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREAD>(arg0, 6, b"BREAD", b"DOG ON BREAD", b"BREAD THE DOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d541306e5750a94cc3404cf41765fe6b_8f1ad26e97.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

