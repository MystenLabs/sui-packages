module 0x14e43fab892c761c893eadc3c95c01c64275dd6aed25d504547a4b8558237775::vn {
    struct VN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VN>(arg0, 9, b"VN", b"VietNam", b"VIET NAM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/97325a6c-0d91-4d60-9267-06193d0c1e27.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VN>>(v1);
    }

    // decompiled from Move bytecode v6
}

