module 0xac6c259f808614091561a6e05ec0b99061f4a7f0a5b68964798006cb3808b171::cati {
    struct CATI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATI>(arg0, 9, b"CATI", b"CATIZEN", b"CATI is a utility token built on the TON BLOCKCHAIN network, with the aim of facilitating transactions within the decentralized ecosystem of dApps focused on the cryptocurrency economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d1a40285-e282-4bfe-ba44-ae76f985cdd9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATI>>(v1);
    }

    // decompiled from Move bytecode v6
}

