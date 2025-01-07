module 0x55fc5158a688513da9b03ce40d892b18c3b3f23c2a642cef945c55af6e9c1dd0::anton35 {
    struct ANTON35 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANTON35, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANTON35>(arg0, 9, b"ANTON35", b"Anton Mako", b"$Cosmos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f738b55-2737-4c86-b85a-d0a6c6f5dcca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANTON35>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANTON35>>(v1);
    }

    // decompiled from Move bytecode v6
}

