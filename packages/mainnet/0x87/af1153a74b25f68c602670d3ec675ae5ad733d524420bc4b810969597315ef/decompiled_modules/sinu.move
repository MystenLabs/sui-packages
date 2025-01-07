module 0x87af1153a74b25f68c602670d3ec675ae5ad733d524420bc4b810969597315ef::sinu {
    struct SINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINU>(arg0, 6, b"SINU", b"Sui Inu", b"Sui Inu - the water dog of SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_d1d3b83133.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

