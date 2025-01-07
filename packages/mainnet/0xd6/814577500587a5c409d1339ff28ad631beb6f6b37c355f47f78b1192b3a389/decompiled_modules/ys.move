module 0xd6814577500587a5c409d1339ff28ad631beb6f6b37c355f47f78b1192b3a389::ys {
    struct YS has drop {
        dummy_field: bool,
    }

    fun init(arg0: YS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YS>(arg0, 9, b"YS", b"yessir", b"0001", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f27e7225-2f7d-419e-93e3-04de6822460b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YS>>(v1);
    }

    // decompiled from Move bytecode v6
}

