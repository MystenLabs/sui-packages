module 0x128b3dd3873dd241c78763a68634f72c7a23f3a4de6d884d23638a5a667d6190::suiretard {
    struct SUIRETARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRETARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRETARD>(arg0, 6, b"SuiRetard", b"retardSuitizen", b"tweet 'get me in lil turd' to get featured in the suitardio hall of fame | the ticker is $STD | A tribute to all retard(io)s on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suitard_353ee27c5d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRETARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRETARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

