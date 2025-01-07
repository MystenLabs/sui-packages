module 0xedd010fc7c308f26e922c54a073c49c9754a62af120e2ffce4893b85fc24abd9::cekke {
    struct CEKKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEKKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEKKE>(arg0, 6, b"CEKKE", b"Cekke Cronje", x"4d454d45204f462053554920414e442045564552594f4e450a0a45766572792065636f73797374656d2068617320612073796d626f6c6963206d656d652c20616e642043454b4b45206973206f6e206974732077617920746f206265636f6d696e672074686520656d626c656d206f6620746865205375692065636f73797374656d2e2043454b4b452773206d697373696f6e20697320746f2061747472616374207573657273206261636b20746f20746865205375692065636f73797374656d2e2045766572796f6e652070617274696369706174696e6720696e207468652070726f6a65637420697320616e20617263686974656374206f662043454b4b452e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Llcfo_Lb_MAAT_1g_U_607c8f006b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEKKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CEKKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

