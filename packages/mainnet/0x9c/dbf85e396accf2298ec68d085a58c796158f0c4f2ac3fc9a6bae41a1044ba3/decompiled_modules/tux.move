module 0x9cdbf85e396accf2298ec68d085a58c796158f0c4f2ac3fc9a6bae41a1044ba3::tux {
    struct TUX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUX>(arg0, 9, b"TUX", b"TUX", b"Meet Tux, the charming penguin from the Arctic, waddling his way to the Sui Blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipenguin.fun/wp-content/uploads/2024/06/20240630_151705_0000-1024x341.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TUX>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUX>>(v1);
    }

    // decompiled from Move bytecode v6
}

