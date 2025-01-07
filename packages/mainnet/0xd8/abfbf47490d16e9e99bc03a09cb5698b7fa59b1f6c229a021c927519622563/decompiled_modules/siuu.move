module 0xd8abfbf47490d16e9e99bc03a09cb5698b7fa59b1f6c229a021c927519622563::siuu {
    struct SIUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUU>(arg0, 6, b"SIUU", b"SUI SIUU", b"SIUU on SUI - community-driven token dedicated GOAT, CR7. Powered by fans, for fans. Join the movement on SUI! Supply controled by Team", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giffer_6e404da0c4_456cb5e70e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

