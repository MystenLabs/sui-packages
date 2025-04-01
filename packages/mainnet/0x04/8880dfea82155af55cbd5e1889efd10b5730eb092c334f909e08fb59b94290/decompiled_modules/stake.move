module 0x48880dfea82155af55cbd5e1889efd10b5730eb092c334f909e08fb59b94290::stake {
    struct STAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAKE>(arg0, 6, b"STAKE", b"Stakecoin", b"Stakecoin is a memecoin that encourages the Sui community to stake their $WAL tokens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_2c210aa788.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

