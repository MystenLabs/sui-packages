module 0x5fe670134dca64a54e2864966cf32828099c99a94080ef3fa1ea248055f2dc9a::wvr {
    struct WVR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WVR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WVR>(arg0, 9, b"WVR", b"Waverider", b"Token  for wave riders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8775b313-5a7a-4196-a4b1-ae4bd5161ed0-1000014080.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WVR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WVR>>(v1);
    }

    // decompiled from Move bytecode v6
}

