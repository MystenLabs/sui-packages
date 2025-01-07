module 0x51662d7ccc285211d3b450f2206bc699f8fc1a42f5f8b793ea029ffe44347df::crypsi {
    struct CRYPSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYPSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYPSI>(arg0, 6, b"CRYPSI", b"Crypsi", b"CRYPSCOIN IS A MEMECOIN DESIGNED TO CHANGE THE FUCKING WORLD (SRY MUM).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015656_e231d16aff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRYPSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

