module 0xc9e208e2b0e560e2fe3358853a9ab1f637410f5e28d4c5ea08c0c72c4c9bc967::cheyenne {
    struct CHEYENNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEYENNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEYENNE>(arg0, 6, b"CHEYENNE", b"CHEYENNE CTO", b"CTO OF THE FIRST ANIMAL IN P'NUTS FREEDOM FARM: cheyenneonsui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_34_7f102b0be9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEYENNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEYENNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

