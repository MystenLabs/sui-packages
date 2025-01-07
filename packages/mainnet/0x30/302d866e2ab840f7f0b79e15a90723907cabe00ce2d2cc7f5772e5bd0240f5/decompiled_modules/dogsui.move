module 0x30302d866e2ab840f7f0b79e15a90723907cabe00ce2d2cc7f5772e5bd0240f5::dogsui {
    struct DOGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSUI>(arg0, 6, b"DogSui", b"Dog Sui", b"The Dog  on #Sui taking us to the mooon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w4r0n8q4_400x400_ea48bd2334.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

