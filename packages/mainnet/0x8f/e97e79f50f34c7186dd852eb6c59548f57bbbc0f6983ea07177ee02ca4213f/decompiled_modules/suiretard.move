module 0x8fe97e79f50f34c7186dd852eb6c59548f57bbbc0f6983ea07177ee02ca4213f::suiretard {
    struct SUIRETARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRETARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRETARD>(arg0, 6, b"Suiretard", b"retardSuitizen", b"tweet 'get me in lil turd' to get featured in the suitardio hall of fame | the ticker is $STD | A tribute to all retard(io)s on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suitard_a2c4c3b478.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRETARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRETARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

