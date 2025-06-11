module 0x6f5dbe8fc26ad398185aa6ba5f14620d18555df3ad81ed27a66aa58cb263fcff::baki {
    struct BAKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAKI>(arg0, 6, b"BAKI", b"BAKI SUI", b"Baki Hanma is the main protagonist of the Baki the Grappler anime and manga series created by Keisuke Itagaki. He's known for his intense dedication to martial arts and his goal of surpassing his father, Yujiro Hanma, the strongest creature on Earth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie2fvasxpdo7is6lzdiwrqwruklrvf2akm6u6zt254uw5ppbsws7m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BAKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

