module 0x8e6ca219cbd48b087947316582baf204bc9b60fafef4b71b307f965bd643705b::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA>(arg0, 6, b"MAGA", b"Sui President", b"A memecoin born to commemorate the great victory of the 47th president of the United States! Long live the MAGA PRESIDENT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731336803863.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

