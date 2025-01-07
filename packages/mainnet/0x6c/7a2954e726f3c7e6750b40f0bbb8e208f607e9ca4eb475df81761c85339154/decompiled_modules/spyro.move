module 0x6c7a2954e726f3c7e6750b40f0bbb8e208f607e9ca4eb475df81761c85339154::spyro {
    struct SPYRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPYRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPYRO>(arg0, 6, b"Spyro", b"Spyro The Dragon", b"Meet Spyro The Dragon your childhood best friend and best friend on the Sui blockchain. Join us as we build our community together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0eb_O_Mw_XM_400x400_8befd75571.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPYRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPYRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

