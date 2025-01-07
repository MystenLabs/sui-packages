module 0xdc4832eba6615dbfd4b22a553f8235dc01fceb304ae0dbb739c6e8c705120ca2::drex {
    struct DREX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DREX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DREX>(arg0, 6, b"DREX", b"Dinosaur Dog", b"Doggosaurus Rex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/drex_6ac7238eae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DREX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DREX>>(v1);
    }

    // decompiled from Move bytecode v6
}

