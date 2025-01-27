module 0xd1dadcf31059748d70021d87bbd67f832a44e871b36fae61ca4c105fcbb5eccc::dataxs {
    struct DATAXS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DATAXS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DATAXS>(arg0, 6, b"DataXS", b"DataX-S AI", x"2e5468652063757474696e672d6564676520667573696f6e206f662068756d616e69747920616e6420746563686e6f6c6f67792e20596f7572207265616c2d74696d6520677569646520746f20626c6f636b636861696e20696e7369676874732c207472656e64732c20616e6420616e616c79746963732e20f09f8c90f09f92a120496e6e6f766174696e672074686520667574757265206f6620646563656e7472616c697a65642073797374656d732e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737968349284.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DATAXS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DATAXS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

