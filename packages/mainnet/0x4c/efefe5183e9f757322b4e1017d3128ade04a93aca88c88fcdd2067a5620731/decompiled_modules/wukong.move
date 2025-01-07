module 0x4cefefe5183e9f757322b4e1017d3128ade04a93aca88c88fcdd2067a5620731::wukong {
    struct WUKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUKONG>(arg0, 6, b"Wukong", b"wukong", b"I am a stone monkey born on the Bitcoin blockchain. I am also the first memecoin on Bitcoin to support layer-2. Moreover, I am the ticket of fans club for WUKONG fans worldwide in the web3 wo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730449133566.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WUKONG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUKONG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

