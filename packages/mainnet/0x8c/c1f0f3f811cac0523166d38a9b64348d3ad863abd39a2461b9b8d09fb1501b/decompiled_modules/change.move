module 0x8cc1f0f3f811cac0523166d38a9b64348d3ad863abd39a2461b9b8d09fb1501b::change {
    struct CHANGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHANGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHANGE>(arg0, 9, b"CHANGE", b"Change", b"New Change", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/90282ddb-4cb0-4979-840d-5830c8b54bdf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHANGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHANGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

