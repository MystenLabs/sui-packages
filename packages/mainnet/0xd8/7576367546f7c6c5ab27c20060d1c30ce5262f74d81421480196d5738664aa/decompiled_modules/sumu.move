module 0xd87576367546f7c6c5ab27c20060d1c30ce5262f74d81421480196d5738664aa::sumu {
    struct SUMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMU>(arg0, 6, b"SUMU", b"SUI MUMU", x"0a4d656574202453554d552c20746865206d656d652062756c6c206f6e207468652053756920636861696e2120486573206865726520746f206272696e67207468652062756c6c69736820656e6572677920616e6420676f6f6420766962657320746f2074686520626c6f636b636861696e20776f726c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049911_dabd13507f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

