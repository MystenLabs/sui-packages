module 0xd1327ac9fe9554b3906ba7ee2977ddc51fc72188863f771b7adca5f9c034562c::tgggh {
    struct TGGGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGGGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGGGH>(arg0, 9, b"TGGGH", b"Ggggg", b"Abbkkf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7a41fbe7-b16a-4ece-8535-5f79c84f1de2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGGGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGGGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

