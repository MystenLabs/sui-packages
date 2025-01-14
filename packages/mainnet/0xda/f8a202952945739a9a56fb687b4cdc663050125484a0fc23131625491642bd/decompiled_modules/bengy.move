module 0xdaf8a202952945739a9a56fb687b4cdc663050125484a0fc23131625491642bd::bengy {
    struct BENGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENGY>(arg0, 6, b"BENGY", b"Bengy On Sui", b"The much-awaited mystery launch on Sui. Bengy on Sui, the Killer Whale, has arrived on the chain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bengi_2f0915a6ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

