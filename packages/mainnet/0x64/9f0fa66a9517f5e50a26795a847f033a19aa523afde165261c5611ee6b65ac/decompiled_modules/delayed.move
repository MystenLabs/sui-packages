module 0x649f0fa66a9517f5e50a26795a847f033a19aa523afde165261c5611ee6b65ac::delayed {
    struct DELAYED has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELAYED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DELAYED>(arg0, 6, b"DELAYED", b"hop fun delayed", b"Wait until post but yes it'll be live the 20th. Ottersec audit not done yet and adding increased protection against malicious teams who try to trade the curve", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_at_23_12_52_bdfda35c9a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DELAYED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DELAYED>>(v1);
    }

    // decompiled from Move bytecode v6
}

