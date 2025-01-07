module 0x410b60ec21fd0825bd3b7ab4e16713120ad351c0b99b80da25b4c892fa6b2e04::popcrab {
    struct POPCRAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPCRAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPCRAB>(arg0, 6, b"POPCRAB", b"CRAB POPCAT IS HERE", x"574841542041524520552057414954494e4720464f52203f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BW_Tk_B_Ve_F_400x400_0e9a5a095a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPCRAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPCRAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

