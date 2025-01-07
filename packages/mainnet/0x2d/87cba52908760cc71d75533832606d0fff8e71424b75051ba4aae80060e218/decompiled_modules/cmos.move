module 0x2d87cba52908760cc71d75533832606d0fff8e71424b75051ba4aae80060e218::cmos {
    struct CMOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMOS>(arg0, 6, b"CMOS", b"Corgi Momo on Sui", b"Momo the Corgi on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735169603135.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CMOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

