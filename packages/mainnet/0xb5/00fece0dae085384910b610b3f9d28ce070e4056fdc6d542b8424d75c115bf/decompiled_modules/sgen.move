module 0xb500fece0dae085384910b610b3f9d28ce070e4056fdc6d542b8424d75c115bf::sgen {
    struct SGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGEN>(arg0, 6, b"SGEN", b"Suigen", b"Depiction of future millionaires!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pp_504x498_pad_600x600_f8f8f8_3ddd11f9d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

