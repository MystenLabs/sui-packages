module 0x27ab74ccee6c864ebfe7c95abb700480933ede72723c5ac74688124c90b2288b::yums {
    struct YUMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUMS>(arg0, 6, b"YUMS", b"YUMPARTY", b"This structure provides a fair distribution of $YUMS tokens through multiple sales, ensuring an immediate reward pool at TGE and a balanced token release schedule for development, team, and partnership growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0165_0dbd7a99ee.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

