module 0x907467485256e279e63499251f94b5da9619114293aef61ef5a493651c78c385::wvr {
    struct WVR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WVR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WVR>(arg0, 9, b"WVR", b"Waverider", b"Token  for wave riders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/288bd324-001c-44fa-ad78-8e17a8f42748-1000014080.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WVR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WVR>>(v1);
    }

    // decompiled from Move bytecode v6
}

