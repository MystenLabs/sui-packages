module 0x3ff1a266747691e7121f0b71691791bfff10d9098b8412d2a35686add62d211f::cb {
    struct CB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CB>(arg0, 9, b"CB", b"Cheeseball", b"Cheeseball $CB mages gathering on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FG_Zh9e_O_Ma_AA_Mk_Vy_c280e61ec3.jpg&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CB>(&mut v2, 200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CB>>(v2, @0x5c9bb147d9ed48100b208a900ab1f8777035fd303522c941d06d5fbc25d68021);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CB>>(v1);
    }

    // decompiled from Move bytecode v6
}

