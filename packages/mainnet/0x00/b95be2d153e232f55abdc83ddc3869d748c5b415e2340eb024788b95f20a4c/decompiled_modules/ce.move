module 0xb95be2d153e232f55abdc83ddc3869d748c5b415e2340eb024788b95f20a4c::ce {
    struct CE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CE>(arg0, 1, b"CE", b"ce", b"C3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CE>(&mut v2, 1000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CE>>(v2, @0x90f9fa841553a37e7c62a0fabcd7785f670b0092444f3df0f536718f0711bded);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CE>>(v1);
    }

    // decompiled from Move bytecode v6
}

