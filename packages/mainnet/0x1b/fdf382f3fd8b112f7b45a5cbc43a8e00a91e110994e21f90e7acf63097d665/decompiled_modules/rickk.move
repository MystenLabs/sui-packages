module 0x1bfdf382f3fd8b112f7b45a5cbc43a8e00a91e110994e21f90e7acf63097d665::rickk {
    struct RICKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICKK>(arg0, 9, b"RICKK", b"Rick coin", b"rick sanchez c-137", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3f6c01f4-5d67-4183-892a-e42a592b3cb8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICKK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICKK>>(v1);
    }

    // decompiled from Move bytecode v6
}

