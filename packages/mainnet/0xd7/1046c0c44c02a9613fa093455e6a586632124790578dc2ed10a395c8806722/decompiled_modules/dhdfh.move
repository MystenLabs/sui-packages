module 0xd71046c0c44c02a9613fa093455e6a586632124790578dc2ed10a395c8806722::dhdfh {
    struct DHDFH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DHDFH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DHDFH>(arg0, 9, b"DHDFH", b"YR", b"SDGSDF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a32a6de4-89f4-40d1-959e-4e394405c715.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DHDFH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DHDFH>>(v1);
    }

    // decompiled from Move bytecode v6
}

