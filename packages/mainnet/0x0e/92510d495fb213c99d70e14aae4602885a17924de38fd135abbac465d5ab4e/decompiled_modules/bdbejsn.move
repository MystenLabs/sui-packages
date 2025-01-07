module 0xe92510d495fb213c99d70e14aae4602885a17924de38fd135abbac465d5ab4e::bdbejsn {
    struct BDBEJSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDBEJSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDBEJSN>(arg0, 9, b"BDBEJSN", b"shsnbsbsbd", x"62c491626273626462736273", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7bb3b676-526f-4410-82af-79f0882fe326.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDBEJSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BDBEJSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

