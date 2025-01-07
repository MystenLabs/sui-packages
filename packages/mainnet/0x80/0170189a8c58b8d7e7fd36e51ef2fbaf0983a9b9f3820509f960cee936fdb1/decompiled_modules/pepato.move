module 0x800170189a8c58b8d7e7fd36e51ef2fbaf0983a9b9f3820509f960cee936fdb1::pepato {
    struct PEPATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPATO>(arg0, 9, b"PEPATO", b"Pepato", x"4920616d2061206269672d657965642c2062726f776e20706f7461746f2c20616e6420766572792061646f7261626c652120f09fa5942020576562736974653a2068747470733a2f2f70657061746f2e736974652020547769747465723a2068747470733a2f2f742e6d652f70657061746f5f737569202054656c656772616d3a2068747470733a2f2f742e6d652f70657061746f5f737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/pepatosui/pepato/refs/heads/main/pepato.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPATO>(&mut v2, 2000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPATO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

