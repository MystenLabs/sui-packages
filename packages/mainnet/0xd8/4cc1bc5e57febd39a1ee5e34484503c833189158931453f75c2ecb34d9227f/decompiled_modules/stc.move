module 0xd84cc1bc5e57febd39a1ee5e34484503c833189158931453f75c2ecb34d9227f::stc {
    struct STC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STC>(arg0, 6, b"STC", b"shitcoin", b"99% of crypto is shit, we just skipped the pretending.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreight5yxa6tghihdt6ngxoi6lw4fdn6yactvqwqpslxe2swctxvpma")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

