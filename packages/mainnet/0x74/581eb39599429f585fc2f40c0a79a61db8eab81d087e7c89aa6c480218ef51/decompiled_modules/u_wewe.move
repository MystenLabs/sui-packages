module 0x74581eb39599429f585fc2f40c0a79a61db8eab81d087e7c89aa6c480218ef51::u_wewe {
    struct U_WEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: U_WEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<U_WEWE>(arg0, 9, b"U_WEWE", b"UVwewe", b"Loading, up, rocket ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f382f3e6-8427-4ed2-9305-dd8840e775b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<U_WEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<U_WEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

