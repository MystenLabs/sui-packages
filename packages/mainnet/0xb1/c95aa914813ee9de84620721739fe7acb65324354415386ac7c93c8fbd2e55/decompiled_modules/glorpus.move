module 0xb1c95aa914813ee9de84620721739fe7acb65324354415386ac7c93c8fbd2e55::glorpus {
    struct GLORPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLORPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLORPUS>(arg0, 6, b"GLORPUS", b"Glorpus on Sui", x"556e697175652c20626f6c642c20616e6420756e61706f6c6f6765746963616c6c7920474c4f525055530a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cp_I_Ikh_OU_400x400_31758fa59c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLORPUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLORPUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

