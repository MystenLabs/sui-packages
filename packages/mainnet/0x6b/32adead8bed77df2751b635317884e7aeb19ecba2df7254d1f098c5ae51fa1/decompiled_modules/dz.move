module 0x6b32adead8bed77df2751b635317884e7aeb19ecba2df7254d1f098c5ae51fa1::dz {
    struct DZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DZ>(arg0, 6, b"Dz", b"ZED", x"4de1bb9974206dc3b42068c3ac6e68207472e1bb936e67207669e1bb856e2074c6b0e1bb9f6e6720706869c3aa75206cc6b075", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/51cff284-2bd1-4bbb-9ee6-eb583de3f192.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

