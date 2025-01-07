module 0x37fce8ec79463680be706a284161bc4e4ef7863ae748174208c9567e4ff158f2::AntlersoftheSacredGuard {
    struct ANTLERSOFTHESACREDGUARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANTLERSOFTHESACREDGUARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANTLERSOFTHESACREDGUARD>(arg0, 0, b"COS", b"Antlers of the Sacred Guard", b"Bowed at the altar... the tree... the mossen effigy...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Antlers_of_the_Sacred_Guard.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANTLERSOFTHESACREDGUARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANTLERSOFTHESACREDGUARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

