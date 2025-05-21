module 0xdcd34708d2ddd1cdde94b1948da45cfc507be54643d9797917f5277f6d5e9a4f::bara {
    struct BARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARA>(arg0, 6, b"Bara", b"Suibara", b"Offical Suibara coin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia33mhefmilzbt73y26wa5443eegqtziunyh46vstv2brgy7iw2my")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BARA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

