module 0xb8dd0f14c64a036caf84f63a91b20fb0907f7b160546cfd6ac2021226d43965c::beeg {
    struct BEEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEEG>(arg0, 6, b"BEEG", b"Beeg blue whale", b"BEEG is a unique and innovative community-driven token designed to foster engagement and participation within the cryptocurrency ecosystem. With a strong focus on transparency and fairness, $BEEG aims to create value for its holders through various strategic initiatives. The project emphasizes community involvement and decentralized governance, ensuring a robust and sustainable growth model for the future. Through thoughtful distribution and a commitment to long-term success, $BEEG strives to be a leading force in the evolving digital currency landscape.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250107_190904_502_6145b6ce0d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

