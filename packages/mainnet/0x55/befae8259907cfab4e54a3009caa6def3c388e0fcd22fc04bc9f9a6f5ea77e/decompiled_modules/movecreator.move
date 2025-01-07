module 0x55befae8259907cfab4e54a3009caa6def3c388e0fcd22fc04bc9f9a6f5ea77e::movecreator {
    struct MOVECREATOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVECREATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVECREATOR>(arg0, 6, b"MOVECREATOR", b"MoveCreator", b"I'm the true Move Creator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TG_Cf_H1_V_400x400_893a111e06.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVECREATOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVECREATOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

