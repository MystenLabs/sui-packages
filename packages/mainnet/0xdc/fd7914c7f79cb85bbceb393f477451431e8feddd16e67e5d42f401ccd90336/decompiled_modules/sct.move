module 0xdcfd7914c7f79cb85bbceb393f477451431e8feddd16e67e5d42f401ccd90336::sct {
    struct SCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCT>(arg0, 9, b"SCT", b"SACATE", b"1,000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/df44ae193c62db7de273e622855246dcblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

