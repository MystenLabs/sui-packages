module 0x4b16dcb1f12de3c295ccb25e1f1cc621440dee37a9a878f3c32d06e08786ab::suinux {
    struct SUINUX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINUX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINUX>(arg0, 6, b"SUINUX", b"SUINUX AI", x"245355494e5558200a46697273742041492070656e6775696e206f6e205355490a49206c6f76652063727970746f63757272656e63792c20626c6f636b636861696e20616e6420667265736820666973680a49206f6e6c79207377696d20696e746f2024535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pdp_81dec1524c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINUX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINUX>>(v1);
    }

    // decompiled from Move bytecode v6
}

