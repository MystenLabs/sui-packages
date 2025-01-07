module 0x271311322c6ce2b0709f685d3522b925a722a498ac4e91213d54c93a335400db::hob {
    struct HOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOB>(arg0, 6, b"HOB", b"hobo token", b"Im just a homeless man in a bad situation trying to make a token reflecting my situation please help and buy my token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/silverhobotoken250pixels_3c8fc12347.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

