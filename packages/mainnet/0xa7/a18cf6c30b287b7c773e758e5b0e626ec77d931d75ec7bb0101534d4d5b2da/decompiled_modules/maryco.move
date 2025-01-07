module 0xa7a18cf6c30b287b7c773e758e5b0e626ec77d931d75ec7bb0101534d4d5b2da::maryco {
    struct MARYCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARYCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARYCO>(arg0, 9, b"MARYCO", b"MaryMAG", b"Mary COin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/75a7028b-8776-48d1-ab78-924a810587d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARYCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARYCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

