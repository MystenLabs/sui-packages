module 0x3178a4aafb5ea4394d394966259e748e6a210aa491b66c8a89d0db86ff462407::crn {
    struct CRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRN>(arg0, 9, b"CRN", b"CRANE", b"First big thing in airdrop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1273fa84-8b25-41f4-b5af-f43489876865.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRN>>(v1);
    }

    // decompiled from Move bytecode v6
}

