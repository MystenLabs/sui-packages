module 0x5c96602e671be2381a09e2ae84cd0ee7c757c245fb0fbe3b3ddcc83318f99900::sbrett {
    struct SBRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBRETT>(arg0, 6, b"SBRETT", b"SUIBRETT", b"From $BASE to $SUI, SuiBrett evolved, faster, stronger, and ready to moon any memecoin in his path! $SBRETT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_20_00_58_015ccee741.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

