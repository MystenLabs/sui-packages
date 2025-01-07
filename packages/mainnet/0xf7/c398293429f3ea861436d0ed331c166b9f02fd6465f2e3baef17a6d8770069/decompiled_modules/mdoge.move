module 0xf7c398293429f3ea861436d0ed331c166b9f02fd6465f2e3baef17a6d8770069::mdoge {
    struct MDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDOGE>(arg0, 6, b"MDoge", b"First Dog In Mars", b"$MDoge - First Dog In Mars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zqy_MW_Oc_Q_400x400_8d48cfa6d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

