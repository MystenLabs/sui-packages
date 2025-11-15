module 0xf432f5cc4a9704539c7fc70ace8957788687415aaa35e04780b26ff97597e678::tge {
    struct TGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGE>(arg0, 6, b"TGE", b"TATO", x"546865206f6666696369616c2043544f20746f6b656e206f6620746865205061777461746f6c616e642045636f73797374656d2e200a0a546865206669727374207669727475616c204e4654206c616e6420436f6c6c656374696f6e206f6e205355490a0a546865206c656164696e67204465466920644170702041676772656761746f7220616e642057616c6c6574204d616e61676572206f6e2053756920e28094206275696c7420746f20657175697020796f75207769746820706f77657266756c20746f6f6c7320746f207468726976652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1763212541405.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

