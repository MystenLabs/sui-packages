module 0x3cb5b0b32fcebec490599c68155703b375cc1cd96ac1096f44d0ed4d37928014::rbtc {
    struct RBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBTC>(arg0, 9, b"RBTC", b"the rabbit", x"4661737420616e6420736d617274207261626269740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d0480c77-a91e-4468-b7a6-957dd0249776.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

