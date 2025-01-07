module 0xd083d685fd24dadbda8793010c5b0dc4e7b1210acb5818e9bc43694707bbec54::zara {
    struct ZARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZARA>(arg0, 6, b"ZARA", b"Zaza on SUI", b"The highest dog on SUI. Light something up and sesh with the $Zaza Pack. CTO. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Yt_Udo_Cn5_400x400_faa271f8c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

