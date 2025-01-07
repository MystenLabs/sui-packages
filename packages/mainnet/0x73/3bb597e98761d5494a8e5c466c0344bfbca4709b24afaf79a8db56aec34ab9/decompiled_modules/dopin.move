module 0x733bb597e98761d5494a8e5c466c0344bfbca4709b24afaf79a8db56aec34ab9::dopin {
    struct DOPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPIN>(arg0, 6, b"Dopin", b"DopinTheSui", x"54686520646f70656420636f6d6d756e69747920636f696e206d616b696e67207761766573206f6e20535549200a405375694e6574776f726b0a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dopin_6381624dfd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOPIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

