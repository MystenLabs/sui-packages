module 0x414ee8158cc6dd49e730cbf420093b617d70c6bbc849ed831324cf1ad904ac2::ponke {
    struct PONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONKE>(arg0, 9, b"PONKE", b"Ponke On Sui", b"THE GOLDEN CHILD ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0x23880df8c37d32bc5bbb7d2005e16f63f7df82ed9889857176f9eb4f6e6148e5::ponke::ponke.png?size=lg&key=bff9d4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PONKE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

