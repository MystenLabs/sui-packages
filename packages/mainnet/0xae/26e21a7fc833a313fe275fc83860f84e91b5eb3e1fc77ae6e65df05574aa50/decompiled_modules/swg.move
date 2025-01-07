module 0xae26e21a7fc833a313fe275fc83860f84e91b5eb3e1fc77ae6e65df05574aa50::swg {
    struct SWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWG>(arg0, 9, b"SWG", b"glass shib", b"shiba with glasses", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/12b68ae6-2c35-469d-9fe6-429b023b1995.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

