module 0x2b8b9a8e3e2ce90f2540468083c71237be4acfdfb9ccdd8c68a017f446ee2766::pookie {
    struct POOKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOKIE>(arg0, 6, b"POOKIE", b"Pookie Cat", b"Sui Very Own Pookie Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_k_O_Oa_T_400x400_21c19745c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOKIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOKIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

