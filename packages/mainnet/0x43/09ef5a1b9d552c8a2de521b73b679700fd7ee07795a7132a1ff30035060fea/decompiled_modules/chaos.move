module 0x4309ef5a1b9d552c8a2de521b73b679700fd7ee07795a7132a1ff30035060fea::chaos {
    struct CHAOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAOS>(arg0, 6, b"CHAOS", b"BIG CHAOS RABBIT", b"The New Meme Mascot of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig3ltblyreshihyxynz63lgmojqdnw2w54kprv4twytf77eyujq3i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHAOS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

