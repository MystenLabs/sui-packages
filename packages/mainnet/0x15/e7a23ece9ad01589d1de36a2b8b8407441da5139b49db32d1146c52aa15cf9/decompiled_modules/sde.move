module 0x15e7a23ece9ad01589d1de36a2b8b8407441da5139b49db32d1146c52aa15cf9::sde {
    struct SDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDE>(arg0, 9, b"SDE", b"SKY", b"THE SKY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e827fa6-5949-4214-b2b0-8a53ca7113c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

