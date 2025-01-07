module 0x223aa6825d10a217aea133dba63cfa4ba22325fb1aa4767789f8393a4e5a482a::elom {
    struct ELOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELOM>(arg0, 6, b"Elom", b"Elom mars", b"Elom mars is  the very first mars cryptocurrency.  They've been looking for the water on mars, but sui waterchain is already there.  Elom is dedicated to Elon Musk's mars mission ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ykahd3_7f785f4e5e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

