module 0xf2506cf550c6b7be19679c796a2d67d559695d6a27c001e4500ba1c1134e3743::mhub {
    struct MHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MHUB>(arg0, 6, b"MHUB", b"Meme Hub", x"73756973656c6620687562200a73746570313a444558200a73746570323a62757920737569207472656e64696e67626f74200a73746570333a746f20746865206d6f6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240920110233_f8383ac463.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MHUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MHUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

