module 0xb0a455ebc1482c66a5f6500065a1547c2c0580b41f18aa79b8d61beb9cbac337::stsui {
    struct STSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STSUI>(arg0, 6, b"STSUI", b"Shih Tzu Sui", x"57656c636f6d6520746f206f757220686f6d652c2077686572652074686520637574657374205368696820547a75205375692072756c65732074686520726f6f737421205072657061726520746f20626520636861726d65642062792074686520666c756666696573742c20667269656e646c696573742c20616e64206d6f73742061646f7261626c65206c6974746c652066757262616c6c2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_3_df9938d71f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

