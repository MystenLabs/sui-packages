module 0x50f0e69de5b879caae58076ba62f9f4862ac655e550d5335fbbb82baa033afe8::bluedork {
    struct BLUEDORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEDORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEDORK>(arg0, 6, b"BlueDork", b"Blue dorklord", b"Iconic matt furie character MILLIOn mcap in other chain, in SUI???", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3852_3d73ba2713.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEDORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEDORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

