module 0x48ed832d949ff239c4f6d643874b23df87360468f0171c3280cb0ad29c97d884::boboonsu {
    struct BOBOONSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBOONSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBOONSU>(arg0, 9, b"BOBOONSU", b"BoBo Me", b"BoBo is BoBo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0d4b5f13-c3a6-403a-ab39-9c43298a3ff9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBOONSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBOONSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

