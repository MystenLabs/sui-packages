module 0x4af07b8d9043af55e62af9b1d6edd07abbe523030c6e61236be9acec71c65bd7::wbuffalo {
    struct WBUFFALO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBUFFALO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WBUFFALO>(arg0, 9, b"WBUFFALO", b"W Buffalo", b"Water Buffalo in Vietnam", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/14a33357-60de-4a8a-a1b4-2cf22a5b8405.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WBUFFALO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WBUFFALO>>(v1);
    }

    // decompiled from Move bytecode v6
}

