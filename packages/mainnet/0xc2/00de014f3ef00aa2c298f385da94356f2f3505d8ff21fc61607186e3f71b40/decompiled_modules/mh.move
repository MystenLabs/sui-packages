module 0xc200de014f3ef00aa2c298f385da94356f2f3505d8ff21fc61607186e3f71b40::mh {
    struct MH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MH>(arg0, 9, b"MH", b"METAHORSE", b"METAHORSE!!NFT HORSE RACING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/64b708db-a8a1-4c03-8335-781b74ee18ce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MH>>(v1);
    }

    // decompiled from Move bytecode v6
}

