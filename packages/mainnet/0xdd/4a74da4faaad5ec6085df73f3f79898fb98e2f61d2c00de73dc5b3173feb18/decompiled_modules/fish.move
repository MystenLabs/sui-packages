module 0xdd4a74da4faaad5ec6085df73f3f79898fb98e2f61d2c00de73dc5b3173feb18::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH>(arg0, 6, b"FISH", b"Hop Fish On Sui", x"4f6e65206461792074686520666973682077696c6c206a756d7020736f206869676820746861742069742077696c6c20666c7920737472616967687420746f0a746865206d6f6f6e2120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_8_E4lh_400x400_cf7be3ec1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

