module 0xd4fc1251377a20515dc914eb7870efff7919cb5446709b7de4e52cf660ec16c5::sui_evf {
    struct SUI_EVF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_EVF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_EVF>(arg0, 6, b"SUI EVF", b"EVOFROG", b"Evolve to the Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicjxr7idelnxdl2l7thgzczd572mgeg5lowk2rd2xklzuriw5gfdy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_EVF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUI_EVF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

