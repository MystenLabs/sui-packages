module 0xeaeba834aab9a2d7749605b7b9fea16f2504ff652082a8bdbc192de61477407::suimon {
    struct SUIMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMON>(arg0, 6, b"SUIMON", b"SUIMON OwO", b"SoMon_OwO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/somon_e492f3a3_7536f93a25.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

