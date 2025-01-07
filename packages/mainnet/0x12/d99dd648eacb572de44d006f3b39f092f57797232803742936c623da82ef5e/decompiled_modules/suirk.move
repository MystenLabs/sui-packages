module 0x12d99dd648eacb572de44d006f3b39f092f57797232803742936c623da82ef5e::suirk {
    struct SUIRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRK>(arg0, 6, b"SUIRK", b"Sui Shark", b"Now $SUIRK is known as the cutest shark on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_08_T003716_491_10ba9e5492.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

