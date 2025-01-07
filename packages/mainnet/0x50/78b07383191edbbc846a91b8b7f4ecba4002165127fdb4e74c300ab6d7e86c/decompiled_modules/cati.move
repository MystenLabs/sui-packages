module 0x5078b07383191edbbc846a91b8b7f4ecba4002165127fdb4e74c300ab6d7e86c::cati {
    struct CATI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATI>(arg0, 9, b"CATI", b"CATIZEN", b"CATI is a utility token built on the TON BLOCKCHAIN network, with the aim of facilitating transactions within the decentralized ecosystem of dApps focused on the cryptocurrency economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/23d1704d-ee3f-4f8e-9445-d3b4fbb70890.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATI>>(v1);
    }

    // decompiled from Move bytecode v6
}

