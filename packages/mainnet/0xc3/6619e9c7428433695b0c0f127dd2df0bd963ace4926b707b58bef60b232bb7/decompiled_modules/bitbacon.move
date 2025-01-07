module 0xc36619e9c7428433695b0c0f127dd2df0bd963ace4926b707b58bef60b232bb7::bitbacon {
    struct BITBACON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITBACON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BITBACON>(arg0, 6, b"BITBACON", b"BITBACON", b"'Bit': Refers to binary digits, the fundamental unit of data in computing and digital technology..'Bacon': A playful or appealing term, often associated with enjoyment or indulgence..Combining these could suggest something like 'a small piece of something highly enjoyable,' potentially in a tech or digital context.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ac516e11_6661_4c68_bb84_809c1d9f827d_207e30c147.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BITBACON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITBACON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

