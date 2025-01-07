module 0x3242ce713257eb871e7559932f4164a85f47e84ea78c76d0616a4daf02da4b4e::suiron {
    struct SUIRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRON>(arg0, 6, b"Suiron", b"Suiron The Abhorred", b"The new Dark Lord of Sui has emerged. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000664547_2a71b43dfe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRON>>(v1);
    }

    // decompiled from Move bytecode v6
}

