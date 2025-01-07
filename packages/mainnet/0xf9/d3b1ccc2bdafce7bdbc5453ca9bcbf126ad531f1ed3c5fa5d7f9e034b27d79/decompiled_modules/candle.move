module 0xf9d3b1ccc2bdafce7bdbc5453ca9bcbf126ad531f1ed3c5fa5d7f9e034b27d79::candle {
    struct CANDLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANDLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANDLE>(arg0, 6, b"CANDLE", b"GOD CANDLE", b"Bitcoin is an open source censorship-resistant peer-to-peer immutable network. Trackable digital gold. Don't trust; verify. Not your keys; not your coins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/od_4a528d55ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANDLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANDLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

