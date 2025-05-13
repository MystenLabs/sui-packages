module 0xdaac3b76f2ff88ec44f502034a3a534e3d4695d34939924cfe59957353409b6d::pollos {
    struct POLLOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLLOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLLOS>(arg0, 6, b"Pollos", b"Pollos Orochi", b"Los Pollos Orochi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiccpykuvazi6nwjtdyhvtv6x6v66nqihzgdhbuuvcsnh3cfy4kgym")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLLOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POLLOS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

