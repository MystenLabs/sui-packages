module 0xb714f1a20bf567bd10183c434c513d7c70090a5f6b542c152d93a78ca2d9d63a::see {
    struct SEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEE>(arg0, 9, b"SEE", b"Sui BEE", b"First BEE on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.ctfassets.net/8dzj5s79jaus/16BvIZNFcECz3dDSr7t7Re/d3984063c0041293d15c60ae067c6fc8/PANGAIA-Bee-The-Change-Landing-PageArtboard_3.jpg?fm=jpg&fl=progressive&q=90")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SEE>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

