module 0x2dbe997402c8480a6b522274ce326a21b546d7ec1a9ec62524ca7484eeb58314::orco {
    struct ORCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCO>(arg0, 6, b"Orco", b"Orco On Sui", b"Let's make a splash on Sui wif $Orco!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/49780eb07c80c8ae170f132a71850ece_3f816404e5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

