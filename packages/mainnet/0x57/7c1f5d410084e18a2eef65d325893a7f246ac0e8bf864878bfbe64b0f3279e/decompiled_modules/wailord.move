module 0x577c1f5d410084e18a2eef65d325893a7f246ac0e8bf864878bfbe64b0f3279e::wailord {
    struct WAILORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAILORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAILORD>(arg0, 6, b"WAILORD", b"WAILORD SUI", b"WAILORD ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicd3axogshpg5j6zjndclqjfxxyfvryvjkyiqfe4o4fmnoxr4gek4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAILORD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAILORD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

