module 0xc42ae364faee028259eb376623bafd9e21dec9d8ca100a7b2a39d7eae7d74971::beethoven {
    struct BEETHOVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEETHOVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEETHOVEN>(arg0, 6, b"Beethoven", b"Beethoven on Sui", b"A Symphony of Opportunity: Beethoven Coin is making history as the first-ever memecoin on the Sui Network! Combining the brilliance of the classical past with cutting-edge blockchain technology, were setting the stage for a revolutionary performance in the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009409_66a27686c5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEETHOVEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEETHOVEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

