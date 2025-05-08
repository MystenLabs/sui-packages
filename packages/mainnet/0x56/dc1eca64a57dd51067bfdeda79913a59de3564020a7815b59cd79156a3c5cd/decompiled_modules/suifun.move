module 0x56dc1eca64a57dd51067bfdeda79913a59de3564020a7815b59cd79156a3c5cd::suifun {
    struct SUIFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFUN>(arg0, 6, b"SUIFUN", b"SUI FUN", b"Spin and Win while enjoying fast payouts total anonymity and provably fair gaming experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicko4bjwainckzjapnz4lr4el6hazqf4udxihhzjcptjx4uywrvau")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIFUN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

