module 0x4d13496a08203a1ac46cd633a31ae5a5d749cc8c2c717346d274201bb423d8bd::wailord {
    struct WAILORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAILORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAILORD>(arg0, 6, b"Wailord", b"WAILORD SUI", b"Wailord is one of the largest Pokemon to have been discovered. Due to its immense size. It can make giant splashes by jumping out of the water and then crashing back down. These shockwaves allow Wailord to knock out its opponents and herd its prey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicd3axogshpg5j6zjndclqjfxxyfvryvjkyiqfe4o4fmnoxr4gek4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAILORD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAILORD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

