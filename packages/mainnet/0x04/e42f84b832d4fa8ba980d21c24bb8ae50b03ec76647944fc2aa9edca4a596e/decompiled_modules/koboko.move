module 0x4e42f84b832d4fa8ba980d21c24bb8ae50b03ec76647944fc2aa9edca4a596e::koboko {
    struct KOBOKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOBOKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOBOKO>(arg0, 6, b"Koboko", b"Koboko on Sui", b"Koboko on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOBOKO>>(v1);
        0x2::coin::mint_and_transfer<KOBOKO>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOBOKO>>(v2, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<KOBOKO>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KOBOKO>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

