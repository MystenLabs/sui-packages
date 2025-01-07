module 0xa14bf21bfc54253a134d91c4b32cc62954d8f8360a1f865a840520ea60a858d6::trident {
    struct TRIDENT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TRIDENT>, arg1: 0x2::coin::Coin<TRIDENT>) {
        0x2::coin::burn<TRIDENT>(arg0, arg1);
    }

    fun init(arg0: TRIDENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIDENT>(arg0, 2, b"Trident", b"TRIDENT", b"Built on Sui, powered by myth and waves of hype. Control the meme seas with trident-strength volatility and dive into the depths of fortune!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/YtWyQqq/trident.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRIDENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIDENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TRIDENT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TRIDENT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

