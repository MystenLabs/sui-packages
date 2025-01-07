module 0x52a3d4e225fcfd266e653af57e02f9e35364358690fbee476c0118db385172b8::army {
    struct ARMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARMY>(arg0, 9, b"ARMY", b"ARMY TOKEN", b"ARRRRRRMYYYYYY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/416cf16d-91a7-4ca7-beea-91192be7cd4c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

