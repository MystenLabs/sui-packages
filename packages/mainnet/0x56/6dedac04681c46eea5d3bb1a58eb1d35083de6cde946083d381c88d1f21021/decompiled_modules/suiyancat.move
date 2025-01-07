module 0x566dedac04681c46eea5d3bb1a58eb1d35083de6cde946083d381c88d1f21021::suiyancat {
    struct SUIYANCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYANCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIYANCAT>(arg0, 6, b"SUIYANCAT", b"suiyancat", b"the most annoying cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/em_Pm_5_O5_400x400_2093010a23.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIYANCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIYANCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

