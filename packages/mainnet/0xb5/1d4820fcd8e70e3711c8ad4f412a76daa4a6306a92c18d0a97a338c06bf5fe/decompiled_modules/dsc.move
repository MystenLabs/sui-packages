module 0xb51d4820fcd8e70e3711c8ad4f412a76daa4a6306a92c18d0a97a338c06bf5fe::dsc {
    struct DSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSC>(arg0, 6, b"DSC", b"DSC on SUI", b"Dev $DSC is an MMA practitioner, tattoo artist and has a project where he gives free MMA classes to children. The meme coin was created to help these child ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736751397674.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

