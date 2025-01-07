module 0x2cd0222ef4fb5913c5e6bcee54566a74d5ac0e2e129417471fa98801326a54af::kim {
    struct KIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIM>(arg0, 6, b"Kim", b"Kim jong Un", b"We can", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kim_jong_un_women_136aa528da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

