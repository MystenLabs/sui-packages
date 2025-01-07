module 0x45a1d0527f60532ee55c5ebee334546ca7099a8207df33a6a95651a07ccb838f::siu {
    struct SIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIU>(arg0, 6, b"SIU", b"Siu Pak", b"https://www.instagram.com/p/CDB--3UBcP6/?igsh=MTdoM2R6aXIyeWQycw==", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4b838d5b_986c_4b3a_af9b_8ae287ba42d7_cfe305284b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

