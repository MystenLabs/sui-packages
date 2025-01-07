module 0xe62178c01199046133453136df9b6ef95946452749fb1de317b84d4eee20e9ad::garm {
    struct GARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARM>(arg0, 9, b"GARM", b"GREEN ARMY", b"GREEN ARMY , GREEN SOLDIOR , GREEN COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/144d5b19-87af-492e-9565-8d6ccbc8cc8b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GARM>>(v1);
    }

    // decompiled from Move bytecode v6
}

