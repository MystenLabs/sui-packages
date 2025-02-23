module 0x75831e8bbef4c33bc5ecffc23640ee7368251f550dd4b0a537019f4b09aa290f::cv20 {
    struct CV20 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CV20, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CV20>(arg0, 6, b"CV20", b"COVIC20", b"DANGEROUS GLOBAL PANDEMIC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/94394c4d-a911-4b09-95ab-1f3a0e82f6e1.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CV20>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CV20>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

