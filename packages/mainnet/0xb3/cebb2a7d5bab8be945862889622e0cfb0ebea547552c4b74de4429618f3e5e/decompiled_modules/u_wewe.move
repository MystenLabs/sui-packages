module 0xb3cebb2a7d5bab8be945862889622e0cfb0ebea547552c4b74de4429618f3e5e::u_wewe {
    struct U_WEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: U_WEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<U_WEWE>(arg0, 9, b"U_WEWE", b"UVwewe", b"Loading, up, rocket ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/895f9806-6a70-47c0-a691-bb02bf46ffbd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<U_WEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<U_WEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

