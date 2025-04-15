module 0xc601125cea21079640e821a21e5faaf7e97af396cf45e1b20674ab395a5173f4::badd0g {
    struct BADD0G has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADD0G, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADD0G>(arg0, 6, b"BADD0G", b"BADD0G MOONBAGS", b"live laugh bros love. bot/archive account for akitouya. tweets every other hour", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibk5zkyagio73opexht3ybqqoemzxneyphv3msjp4ap3uh3tntzwa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADD0G>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BADD0G>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

