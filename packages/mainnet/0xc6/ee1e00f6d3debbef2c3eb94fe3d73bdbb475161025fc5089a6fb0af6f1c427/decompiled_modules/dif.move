module 0xc6ee1e00f6d3debbef2c3eb94fe3d73bdbb475161025fc5089a6fb0af6f1c427::dif {
    struct DIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIF>(arg0, 6, b"DIF", b"dickwifhat", x"4449462069732073746f726d696e67207468652063727970746f207363656e65207769746820612073776167676572206f6e6c792061204469636b7769666861742063616e2e20496d6167696e65206120776f726c642077686572652066696e616e6365206765747320612066756e206d616b656f7665722c20616e6420696e766573746d656e7420616476696365206d69676874206a75737420696e636c7564650a5768656e204469636b2077656172732061206861742c207761746368206f757420666f72207468652062756c6c7321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o_Si_C7_Wij_400x400_a65c6849a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

