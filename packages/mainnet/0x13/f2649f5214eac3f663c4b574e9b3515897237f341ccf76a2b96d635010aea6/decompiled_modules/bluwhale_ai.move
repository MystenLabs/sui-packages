module 0x13f2649f5214eac3f663c4b574e9b3515897237f341ccf76a2b96d635010aea6::bluwhale_ai {
    struct BLUWHALE_AI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BLUWHALE_AI>, arg1: 0x2::coin::Coin<BLUWHALE_AI>) {
        0x2::coin::burn<BLUWHALE_AI>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BLUWHALE_AI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BLUWHALE_AI>>(0x2::coin::mint<BLUWHALE_AI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BLUWHALE_AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUWHALE_AI>(arg0, 9, b"BLUAI", b"Bluwhale AI", b"Bluwhale AI Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUWHALE_AI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUWHALE_AI>>(v1);
    }

    // decompiled from Move bytecode v6
}

