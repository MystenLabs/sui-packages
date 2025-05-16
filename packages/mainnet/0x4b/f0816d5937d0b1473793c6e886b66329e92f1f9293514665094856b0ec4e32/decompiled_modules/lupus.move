module 0x4bf0816d5937d0b1473793c6e886b66329e92f1f9293514665094856b0ec4e32::lupus {
    struct LUPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUPUS>(arg0, 6, b"LUPUS", b"Lupus the Wolf", b"DeFi cunning predator. Built for chaos, driven by profit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib2zzrtmnxwrodj5dy7jeqn56vadl2wbn6zq2qaomz4btgqbqtmjy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUPUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUPUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

