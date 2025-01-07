module 0x60f2392ec7baff08928efcaf9689cd21f9cffa44af046c374a76fd704ed94d77::vgl {
    struct VGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: VGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VGL>(arg0, 9, b"VGL", b"VERITAS GL", b"VERITAS is a video MONETISATION software that helps users earn from watching video contents either posted by them or by others with the help of their software.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a8c6b0d1-bfe8-49cc-97aa-7f57d10f2046.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VGL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VGL>>(v1);
    }

    // decompiled from Move bytecode v6
}

