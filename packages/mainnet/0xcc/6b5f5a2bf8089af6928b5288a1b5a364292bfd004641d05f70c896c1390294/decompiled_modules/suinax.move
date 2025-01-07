module 0xcc6b5f5a2bf8089af6928b5288a1b5a364292bfd004641d05f70c896c1390294::suinax {
    struct SUINAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAX>(arg0, 6, b"SUINAX", b"SuinaX", x"54686520636572746966696564204261642d4173732044697661206f6e205375692c206272696e67696e6720476c616d6f75722c20486f746e6573732c20616e6420616e20456d70697265206f6e20746865207269736520746f20636c61696d206865722063726f776e2061732074686520756c74696d61746520517565656e206f66207468652053756920626c6f636b636861696e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/profile_33764066d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

