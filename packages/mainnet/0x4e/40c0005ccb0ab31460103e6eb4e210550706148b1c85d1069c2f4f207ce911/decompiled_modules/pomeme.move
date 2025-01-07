module 0x4e40c0005ccb0ab31460103e6eb4e210550706148b1c85d1069c2f4f207ce911::pomeme {
    struct POMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: POMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POMEME>(arg0, 6, b"POMEME", b"POCHITA'S MEME", b"Prepare to be captivated by the latest blockchain sensation - $POMEME, the groundbreaking Pochita's Meme that is set to revolutionize the digital world! This innovative and captivating meme is not just a passing trend but a valuable asset that embodies the essence of creativity and innovation on the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_21_11_50_bd6350fd21.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

