module 0xa010e7a1a679195f585823b71988bb05df0c22a4d17be21287f9ce664b4a1107::cuca {
    struct CUCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUCA>(arg0, 9, b"CUCA", b"Chautao", b"Just prank him", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/747a07c0-64b5-4d7f-bfc5-9d11d34aac58.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

