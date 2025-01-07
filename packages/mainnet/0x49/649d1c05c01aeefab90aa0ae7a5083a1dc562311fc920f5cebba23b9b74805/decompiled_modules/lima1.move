module 0x49649d1c05c01aeefab90aa0ae7a5083a1dc562311fc920f5cebba23b9b74805::lima1 {
    struct LIMA1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIMA1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIMA1>(arg0, 9, b"LIMA1", b"LIMA", b"testnet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/48f252cd-a2a7-4647-9416-2fb8ddb06916.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIMA1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIMA1>>(v1);
    }

    // decompiled from Move bytecode v6
}

