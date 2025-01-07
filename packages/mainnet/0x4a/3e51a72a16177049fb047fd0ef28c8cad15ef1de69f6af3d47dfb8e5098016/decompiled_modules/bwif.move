module 0x4a3e51a72a16177049fb047fd0ef28c8cad15ef1de69f6af3d47dfb8e5098016::bwif {
    struct BWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWIF>(arg0, 6, b"BWIF", b"BLUBWIF", b"A Dirty Fish with a Hat in the Waters of the Sui Ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BLUBWIF_56efb67fee.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

