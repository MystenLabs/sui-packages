module 0x43c32ab3b39e50738bd6dc9947cb082f44018830065a45b025f7420e56ced9fa::creme {
    struct CREME has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREME>(arg0, 6, b"CREME", b"Creme", x"43726d652069732066696e616c6c79206f6e2074686520626c6f636b636861696e20616e6420726561647920746f20626f6e642e2057696c6c2073686520657665722073656c6c2e2e2e2e2248454c4c204e41572121220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_Mo_Cn_Lt2_400x400_77383d0291.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CREME>>(v1);
    }

    // decompiled from Move bytecode v6
}

