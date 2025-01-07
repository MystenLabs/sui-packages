module 0xf821294dc6b17df948789ce8f60332fe255a48f75f5c051ca967978aa5aa068::spien {
    struct SPIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIEN>(arg0, 6, b"SPIEN", b"SUIPIENS", b"OG Community on $Sui Ecosystem. hare the news, strategy to build your wealth on @suinetwork ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n_Sx_W_Miq_T_400x400_48b1d5d622.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

