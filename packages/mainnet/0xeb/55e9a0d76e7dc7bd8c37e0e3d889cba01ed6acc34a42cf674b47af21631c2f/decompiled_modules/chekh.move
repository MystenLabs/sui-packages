module 0xeb55e9a0d76e7dc7bd8c37e0e3d889cba01ed6acc34a42cf674b47af21631c2f::chekh {
    struct CHEKH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEKH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEKH>(arg0, 9, b"CHEKH", b"chekhov", b"Anton chekhov", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/697439e2-1946-42db-9731-5062d4d5b743.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEKH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEKH>>(v1);
    }

    // decompiled from Move bytecode v6
}

