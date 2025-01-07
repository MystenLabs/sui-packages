module 0xbf1cc4eae414963eefc125113464d01abad88e484bd6dd9b3de47649e11d2d76::pepex {
    struct PEPEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEX>(arg0, 6, b"Pepex", b"Pepex Sui", b"Bring her to kek!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4fc80d6729bf08cc30b5c2612882c392_30515f6df8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

