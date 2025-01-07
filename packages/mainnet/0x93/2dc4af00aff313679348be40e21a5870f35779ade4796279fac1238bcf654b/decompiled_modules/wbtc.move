module 0x932dc4af00aff313679348be40e21a5870f35779ade4796279fac1238bcf654b::wbtc {
    struct WBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WBTC>(arg0, 6, b"WBTC", b"Whales BTC", b"Whales BTC ($WBTC) channels the strength and grandeur of oceanic whales to bring wealth to its holders. Just as whales symbolize abundance, $WBTC aims to deliver prosperity in the crypto sea, making it your ticket to ride the waves of fortune", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732084420925.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

