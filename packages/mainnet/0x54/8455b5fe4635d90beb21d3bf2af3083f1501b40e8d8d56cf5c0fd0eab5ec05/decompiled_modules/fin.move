module 0x548455b5fe4635d90beb21d3bf2af3083f1501b40e8d8d56cf5c0fd0eab5ec05::fin {
    struct FIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIN>(arg0, 6, b"Fin", b"Finlay", b"Finlay the shark dog, look how cute his is!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/finlay_56486f0435.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

