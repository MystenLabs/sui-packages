module 0xf08abc64fb8f242cfd35ecc713a3f50ce625aaebb8ffdfb315f75eaf1889a49d::movecreator {
    struct MOVECREATOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVECREATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVECREATOR>(arg0, 6, b"MOVECREATOR", b"MoveCreator", b"I'm the true Move Creator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TG_Cf_H1_V_400x400_5388a6207a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVECREATOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVECREATOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

