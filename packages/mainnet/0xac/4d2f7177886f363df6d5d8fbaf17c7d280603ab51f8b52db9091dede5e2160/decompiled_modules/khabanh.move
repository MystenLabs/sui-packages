module 0xac4d2f7177886f363df6d5d8fbaf17c7d280603ab51f8b52db9091dede5e2160::khabanh {
    struct KHABANH has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHABANH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHABANH>(arg0, 9, b"KHB", b"KHABANH", b"Meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://15065ae3c21e0bff07eaf80b713a6ef0.ipfscdn.io/ipfs/bafybeifqmx3d3hwaacspjdzvczrjufgykfxs53cvgrqo4jkk6t2q22pphm/Your%20paragraph%20text%20(1).png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHABANH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHABANH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

