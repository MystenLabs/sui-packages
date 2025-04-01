module 0x7d6473d645536d8326112afc7bd3df6f90250117394caf6644c192c37968f661::nifari {
    struct NIFARI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIFARI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIFARI>(arg0, 6, b"Nifari", b"NefariNigga", b"Gimme WL airdrop or I'll set the tribe on you... I need to change my profile picture to those gay robots. Let me farm and start bragging about it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2025_04_01_230735142_872aa91298.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIFARI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIFARI>>(v1);
    }

    // decompiled from Move bytecode v6
}

