module 0xdb0bdb7197f17afc30162a8d43d7e1179bff34a11363e7d540e17b87f83287a6::suichan {
    struct SUICHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHAN>(arg0, 6, b"SUICHAN", b"Sui Chan", x"4d656574205375692d6368616e2120426f726e2066726f6d20537569277320626c6f636b636861696e20656e657267792c206865e2809973206865726520746f207669626520616e642067726f7720776974682074686520636f6d6d756e6974792e205269676874206e6f772c206865e2809973206368696c6c696ee280992c2062757420617320746865205375692065636f73797374656d20657870616e64732c20736f2077696c6c2068697320706f776572732e20537469636b2061726f756e6420746f207761746368205375692d6368616e2065766f6c766521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730490647364.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICHAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

