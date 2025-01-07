module 0x4c646ca9a543a9922233c904f63591b690e8e0d00fa50f148b92dc992b74eb27::bhjknnb {
    struct BHJKNNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHJKNNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHJKNNB>(arg0, 9, b"BHJKNNB", b"Pi", b"Pi Network celebrates 2000 days since its official launch on March 14, 2019! This milestone reflects the steady, ongoing efforts of our community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/51a97a16-bf0c-414d-bb8a-1f72aab7872b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHJKNNB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BHJKNNB>>(v1);
    }

    // decompiled from Move bytecode v6
}

