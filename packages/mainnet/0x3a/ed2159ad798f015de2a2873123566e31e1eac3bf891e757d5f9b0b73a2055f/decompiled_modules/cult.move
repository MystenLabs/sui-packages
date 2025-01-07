module 0x3aed2159ad798f015de2a2873123566e31e1eac3bf891e757d5f9b0b73a2055f::cult {
    struct CULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CULT>(arg0, 6, b"CULT", b"CULT", b"CULT on billions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media1.tenor.com/m/MDRpaaAmIWYAAAAC/vanis.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CULT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CULT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CULT>>(v1);
    }

    // decompiled from Move bytecode v6
}

