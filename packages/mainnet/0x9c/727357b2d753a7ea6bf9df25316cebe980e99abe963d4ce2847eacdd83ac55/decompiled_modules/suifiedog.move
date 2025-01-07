module 0x9c727357b2d753a7ea6bf9df25316cebe980e99abe963d4ce2847eacdd83ac55::suifiedog {
    struct SUIFIEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFIEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFIEDOG>(arg0, 6, b"SuifieDog", b"Suifie Dog", x"546865206669727374206576657220446f6720656d6f6a692063756c74206f6e205375692e204f757220766973696f6e20697320746f20736565205355492077696c6c206f76657274616b6520534f4c414e412e205375696669652077696c6c20626520612042696c6c696f6e20446f6c6c6172204d454d45206f6e205355492e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DHU_Zu_yw_400x400_a34c2959a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFIEDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFIEDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

