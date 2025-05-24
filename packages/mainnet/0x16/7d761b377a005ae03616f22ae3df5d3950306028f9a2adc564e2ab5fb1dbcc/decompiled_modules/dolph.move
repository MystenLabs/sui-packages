module 0x167d761b377a005ae03616f22ae3df5d3950306028f9a2adc564e2ab5fb1dbcc::dolph {
    struct DOLPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPH>(arg0, 6, b"DOLPH", b"DolphinVerse", x"57656c636f6d6520746f20446f6c7068696e566572736520200a546865206d656d6520746f6b656e206d616b696e67207761766573206f6e207468652053756920626c6f636b636861696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifa53s7lhtwpeenmdivxfmatxk3r5oujteuw4dvja7qt5j2esd2tq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOLPH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

