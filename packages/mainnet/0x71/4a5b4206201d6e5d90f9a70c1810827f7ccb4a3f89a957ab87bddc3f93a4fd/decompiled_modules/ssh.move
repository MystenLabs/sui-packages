module 0x714a5b4206201d6e5d90f9a70c1810827f7ccb4a3f89a957ab87bddc3f93a4fd::ssh {
    struct SSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSH>(arg0, 9, b"SSH", b"SUISH", b"SO FUCKN BULLISH ON SUISH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bad535ad-fb51-4743-853b-10ab2b83468d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

