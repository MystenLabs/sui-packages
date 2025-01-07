module 0xd55cafd5fab71e104690f6f447b4afe87d72f139bdda62cb02b056dbfd8ebd74::suimer {
    struct SUIMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMER>(arg0, 6, b"SUIMER", b"SUI DOOMER", b"Crypto has doomed us all! I now cry tears of sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_1dc42ea21c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

