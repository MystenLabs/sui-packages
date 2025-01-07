module 0xe56ab4dd822a882da5bda8eb8382391d9c2b83593223fa01d21e50012870dd0c::fnz {
    struct FNZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNZ>(arg0, 9, b"FNZ", b"FANZA", b"Enhonorafanzita", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3WtQk_TyZCTLKSL-GFx1VFWD3UF28bddT-6H0hifzlnrzTQNq-1gugg48dQLP-z-NWUU&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FNZ>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNZ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FNZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

