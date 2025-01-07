module 0xbfc8c4a4ff0dcd15984f84a92ef467408f9bcfdf82fd6b7b9589bf256518128d::jfish {
    struct JFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JFISH>(arg0, 6, b"JFISH", b"$JELLYFISH", b"$JELLYFISH ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_ae_dc6fed179d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

