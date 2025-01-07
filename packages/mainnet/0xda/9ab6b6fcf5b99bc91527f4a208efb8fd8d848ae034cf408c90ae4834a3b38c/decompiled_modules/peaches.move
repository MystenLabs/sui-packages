module 0xda9ab6b6fcf5b99bc91527f4a208efb8fd8d848ae034cf408c90ae4834a3b38c::peaches {
    struct PEACHES has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEACHES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEACHES>(arg0, 6, b"PEACHES", b"Peach Cat On Sui", b"Cat Holding a Peach", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Luj_Dy8_Jg_400x400_726144bdf1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEACHES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEACHES>>(v1);
    }

    // decompiled from Move bytecode v6
}

