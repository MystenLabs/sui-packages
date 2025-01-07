module 0x632bdf71cba7c93b39cb57e117da999499f36fac0533dd86f87d1b4302414e07::sump {
    struct SUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMP>(arg0, 6, b"SUMP", b"Seal Trump", b"Seal Trump the president seal , The leader of all the seals, the victory seal that sealed victory, prosperity for all HU-RA ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/openart_image_dd_Hlx_Sp_C_1731735196277_raw_1_32135b45ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

