module 0xa37a429b9ffc4c5d6c1d7dbebf73c15bc61124f66fd30081bc9eb52a642aea4e::rza {
    struct RZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RZA>(arg0, 9, b"RZA", b"Ruza", b"Its okay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f5000511-4da3-4126-b267-d3ad977e73a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

