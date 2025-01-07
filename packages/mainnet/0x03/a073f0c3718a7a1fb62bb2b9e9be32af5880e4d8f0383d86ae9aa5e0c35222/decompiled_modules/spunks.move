module 0x3a073f0c3718a7a1fb62bb2b9e9be32af5880e4d8f0383d86ae9aa5e0c35222::spunks {
    struct SPUNKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUNKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUNKS>(arg0, 6, b"SPUNKS", b"SUIPUNKS", b"$SPUNKS is a memecoin launched on the Sui network, inspired by the iconic CryptoPunks. As a fun and lighthearted version of the famous NFTs, $SPUNKS combines the pixelated style of Punks with memecoin culture, aiming to attract the crypto community with a nostalgic and innovative twist, while leveraging the speed and efficiency of the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/_facd46edb2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUNKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUNKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

