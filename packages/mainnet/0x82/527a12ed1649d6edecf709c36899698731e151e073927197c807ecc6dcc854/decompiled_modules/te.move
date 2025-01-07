module 0x82527a12ed1649d6edecf709c36899698731e151e073927197c807ecc6dcc854::te {
    struct TE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TE>(arg0, 9, b"TE", b"TE", b"TE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiUoz7-zLs596k0CVb4dOuEsmarb_QeVzOeA&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TE>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

