module 0x28fe5fb75cb156658aa24a2f123a285d83d26f863cb660beae8d0c8fb3b29a7f::paulasco {
    struct PAULASCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAULASCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAULASCO>(arg0, 9, b"PAULASCO", b"Paul", b"Token of dm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c72aa1bd-49d3-41ca-9c5b-fe1211cfecef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAULASCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAULASCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

