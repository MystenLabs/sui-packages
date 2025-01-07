module 0xfbf6fbf64ee70e0944a6a69375749087d7ab11d0dbc6d6e0a5ed9a8f4727831::capoo {
    struct CAPOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPOO>(arg0, 6, b"CAPOO", b"Sui capoo", b"$CAPOO - THE SILLIEST CAT ON SUI Capoo has become the most famous sticker pack on LINE, spawning multiple games, coffeeshops and related merchandise", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052457_8c3fcf4a58.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

