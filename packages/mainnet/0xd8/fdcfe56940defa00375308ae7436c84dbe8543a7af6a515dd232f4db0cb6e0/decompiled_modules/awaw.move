module 0xd8fdcfe56940defa00375308ae7436c84dbe8543a7af6a515dd232f4db0cb6e0::awaw {
    struct AWAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWAW>(arg0, 9, b"AWAW", b"Awawaw", b"Awawawawa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/89fbd44d-1ca6-4271-b567-11cacfe6293b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

