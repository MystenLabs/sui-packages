module 0xdb13693d3c3128d1d08c146a40e1b3e845d1b32a366614c73f13ac91fec78bb5::suicoco {
    struct SUICOCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICOCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICOCO>(arg0, 6, b"SUICOCO", b"COCO on SUI", x"47657420726561647920746f20726964652074686520676e61726c696573742077617665206f662074686520535549206f6365616e20200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_A_Br_XJ_9_D_400x400_c5e79d7209.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICOCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICOCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

