module 0xfc42cb62532ad627f1f8337a1457499ae39481c846b5e3121c876d0035e31a1f::rse {
    struct RSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSE>(arg0, 9, b"RSE", b"Rise", b"Rise is a revolutionary green energy token designed to promote sustainability and environmental responsibility. Every transaction supports renewable energy projects worldwide, empowering communities while reducing carbon footprints. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c0189e6a-6353-4956-8891-3c18ebeb9505.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

