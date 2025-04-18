module 0x71daabcf192016908414d5465a33eb6241a6790ccbc620d8c626c7c2b1859106::froggys {
    struct FROGGYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGYS>(arg0, 6, b"FROGGYS", b"FROGGYSUI", b"I LOVE PEPE ON SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7b08b9b7_28ce_42b4_911d_808645a21043_d3cbd2a059.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGGYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

