module 0x14f71809547f6b6ce887a03004a2ab2daed1f93a669a70e8c1a226da3ef6e6aa::benhuhh {
    struct BENHUHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENHUHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENHUHH>(arg0, 6, b"BENHUHH", b"BENHUHH-T", b"Meet Ben, The 'Huh' Cat with Hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_822883b952.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENHUHH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENHUHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

