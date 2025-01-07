module 0x8406e33621b4c5de89d3dd1ec5410f0480e42ad985002bb41ad3281065179b6f::fenn {
    struct FENN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENN>(arg0, 6, b"FENN", b"Fenn", b"$FENN - Party hard. Trade harder. Get rich.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FENNXD_7684dd28d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FENN>>(v1);
    }

    // decompiled from Move bytecode v6
}

