module 0xe5cd13b65d8b9aac13caa3251df682c12d6f5eae4839130aa979baa5931fe4ec::opk {
    struct OPK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPK>(arg0, 6, b"OPK", b"OPK-OBI-PNUT-KENOBI ", x"6d656d65206e616d653a204f504b20692e652e20224f424920504e5554204b454e4f424922202c0a6d6f7469663a204a55535449434520464f52205045414e55542054484520535155495252454c202c0a7265662e205452554d5020616e64204d55534b2054574545545320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731105984955.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

