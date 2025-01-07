module 0x4d2a39a25aa0e3da9a9ec8ecd088acfcfb02bd40d451d7e3d069f6ef82988515::chuckle {
    struct CHUCKLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUCKLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUCKLE>(arg0, 9, b"CHUCKLE", b"Chucklecon", b"Memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a60ea64a-e362-4185-b1fd-c05626f138fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUCKLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHUCKLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

