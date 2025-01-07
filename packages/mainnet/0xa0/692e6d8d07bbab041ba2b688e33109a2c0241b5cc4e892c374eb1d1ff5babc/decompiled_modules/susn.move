module 0xa0692e6d8d07bbab041ba2b688e33109a2c0241b5cc4e892c374eb1d1ff5babc::susn {
    struct SUSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSN>(arg0, 9, b"SUSN", b"Suisn", x"537569736e20285355534e292069732061206e617469766520636f696e206f6e207468652053756920426c6f636b636861696e2c2064657369676e656420666f7220666173742c207365637572652c20616e64207363616c61626c65207472616e73616374696f6e732e20497420706f7765727320646563656e7472616c697a656420617070732c207374616b696e672c20616e6420676f7665726e616e63652077697468696e20746865205375692065636f73797374656d2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7587da22-1144-437b-8868-f6d5570929bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

