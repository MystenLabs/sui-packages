module 0xc60eeae744c9d755af31ca551228bb78e647333c0764d5dc870622efb1da48ea::meko {
    struct MEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEKO>(arg0, 6, b"MEKO", b"Meko", b"Meko is a leading memecoin on the Sui blockchain, with a primary focus on building a strong and solid community. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241118_121118_7c0afcb68f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

