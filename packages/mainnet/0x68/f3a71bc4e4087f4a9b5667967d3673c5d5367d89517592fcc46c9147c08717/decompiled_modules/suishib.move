module 0x68f3a71bc4e4087f4a9b5667967d3673c5d5367d89517592fcc46c9147c08717::suishib {
    struct SUISHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIB>(arg0, 6, b"Suishib", b"SUISHIB", b"Suishib is a new generation memecoin that brings the spirit of Shiba to the Sui blockchain in a way youve never seen before! Built for those who dare to dream big and seek excitement in crypto, Suishib is not just about investmentit's an epic adventure in the super-fast Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241010_141618_1c180af841.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

